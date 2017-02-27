`import Ember from 'ember'`
`import layout from 'terms-manager/templates/components/term-item'`

TermItemComponent = Ember.Component.extend(
  layout: layout
  classNameBindings: ['dirty', 'shouldHighlight:focus']
  classNames: ['term']

  type: "term"
  saveAllButton: Ember.inject.service()
  init: ->
    @_super()
    @get('saveAllButton').subscribe(@)

  keyboardShortcuts: Ember.computed 'disableShortcuts', ->
    if @get('disableShortcuts') then return {}
    else
      obj=
      {
        'ctrl+alt+d':
          action: 'deleteTerm'
          scoped: true
        'ctrl+alt+o':
          action: 'toggleSource'
          scoped: true
          preventDefault: true
      }
      if @get('showQuest')
        obj['ctrl+alt+q']=
          action: 'goToQuestUrl'
          scoped: true
      obj

  showQuestIfNotEmpty: Ember.computed 'term.literalForm', ->
    if @get('term.literalForm') then return true else return false

  pathToQuest: Ember.computed 'term.literalForm', ->
    term = @get('term')
    target = @get('targetLanguage')
    source = "en"
    if term.get('literalForm')
      text = term.get('literalForm')
      return @createQuestUrl(text, source, target)
    else
      return ""

  dirty: Ember.computed.alias 'term.dirty'

  saveField: ->
    term = @get('term')
    @managePrefTermSaving(term, false)
    term.save().then((model) =>
      unless @get('isDestroyed')
        console.log "success on save"
        @set('saveStatus', "success")
      return
    ).catch(=>
      console.log "failure on save"
      unless @get('isDestroyed')
        @set('saveStatus', "failure")
      return
    )


  saveAllClick: ->
    @saveField()

  resetField: ->
    @get('term')?.rollback()

# new stuff in there #

  managePrefTermSaving: (term, save) ->
    promises = []
    termRoles = @parseRolesFromString(term)
    if termRoles.length > 0
      term.set('roles', [])
      promises.push(@setGender(term, false, "neutral"))
    termRoles.forEach (role) =>
      if ["standard female term", "standard male term"].contains role
        if role is "standard female term" then promises.push(@setAsPreferred(term, false, "female", true))
        else if role is "standard male term" then promises.push(@setAsPreferred(term, false, "male", true))
    Ember.RSVP.Promise.all(promises).then =>
      if save then term.save()

  actions:
    saveField: ->
      @saveField()

    resetField: ->
      @resetField()

    toggleNeutral: (term) ->
      @setGender(term, true, 'neutral')
    removePrefTerm: (term, index) ->
      @sendAction('removePrefTerm', term, index)
    goToQuestUrl: ->
      if @get 'showQuest'
        url = @get('pathToQuest')
        if @get 'showQuestIfNotEmpty'
          window.open(url)

    prefTermContentModified: (term, event) ->
      if event.keyCode == 13 # Enter key
        @saveField()
      else
        @changeTermValue(term, event.target.value, false)

    deleteTerm: ->
      term = @get('term')
      @changeTermValue(term, '', false)
      term.set('source', null)
      if term.get('id') then term.save()
)

`export default TermItemComponent`