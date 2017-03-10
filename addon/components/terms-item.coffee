`import Ember from 'ember'`
`import layout from '../templates/components/terms-item'`

TermsItemComponent = Ember.Component.extend
  layout: layout
  classNames: ['term']
  classNameBindings: ['focused:focus', 'dirtyOrNew', 'term.isDeleted:deleted', 'savedAndNotDirty:saved',
    'term.failedSave:failed', 'term.failedReload:failed', 'term.isLoading:loading', 'nameIndex']
  nameIndex: Ember.computed 'name', 'index', ->
    return "#{@get('name')}#{@get('index')}"

  # whether changes are allowed
  disabled: false
  shouldDisable: Ember.computed 'loading', 'disabled', ->
    return @get('disabled') or @get('loading')
  loading: Ember.computed 'loadingRoles', ->
    return @get('loadingRoles')
  # whether shortcuts are disabled
  disableShortcuts: false

  # whether the delete button should be disabled
  displayDelete: true
  # whether the source component should be displayed
  displaySource: true
  # boolean to toggle / untoggle sources
  toggledSource: false

  # whether the source component should be displayed
  displaySuggestions: true
  # boolean to toggle / untoggle sources
  toggledSuggestions: false

  # checks whether the term is dirty (make sure the model has this property)
  dirty: Ember.computed 'term.dirty', ->
    if @get('term.dirty') is true then return true
    else if @get('term.dirty') is false then return false
    else
      console.warn "Term model does not seem to have a 'dirty' property"
      return false
  dirtyOrNew: Ember.computed 'dirty', 'term.isNew', ->
    if @get('term.isNew') then return "new"
    else if @get('dirty') then return "dirty"
  savedAndNotDirty: Ember.computed 'term.isSaved', 'dirty', ->
    return @get('term.isSaved') and not @get('dirty')

  saveable: Ember.computed 'displayActionsTerm', 'displayActionsNewTerm', ->
    if @get('term.isNew') then return @get('displayActionsNewTerm')
    else return @get('displayActionsTerm')
  displayActionsTerm: Ember.computed.alias 'dirty'
  displayActionsNewTerm: Ember.computed 'term.literalForm.length', ->
    debugger
    if @get('term.literalForm.length') > 0 then return true
    return false

  parseRolesFromString: (term) ->
    array = []
    literalform = term.get('literalForm')
    split = literalform.split('//', -1)
    genders = split[1]

    term.set('literalForm', split[0].trim())
    if genders is undefined or genders.trim().length is 0
      return new Ember.RSVP.Promise =>
        return []

    if genders.indexOf("sm") >= 0 then array.push('standard male term')
    else if genders.indexOf("m") >= 0 then array.push('male')

    if genders.indexOf("sf") >= 0 then array.push('standard female term')
    else if genders.indexOf("f") >= 0 then array.push('female')

    if genders.indexOf("none") >= 0 then array.push('none')
    else if genders.indexOf("n") >= 0 then array.push('neutral')

    if array.length > 0
      console.log "removing all roles from term : #{term.get('id')}"
      term.set('roles', [])
    else return new Ember.RSVP.Promise =>
      return []

    @get('roles')?.then (roles) =>
      roles.forEach (role) =>
        if array.contains(role.get('preflabel')) then @sendAction('toggleGender', term, role)

  saveAllClick: ->
    @saveTerm()

  saveTerm: ->
    if @get('disabled') then return false
    if @get('term.literalForm.length') is 0
      console.log "can not save empty term"
      return false
    # TODO : Handle
    term = @get('term')
    name = @get('name')
    index = @get('index')

    console.log "Handle saving of term"
    term.save().then( (savedTerm) =>
      unless @get('isDestroyed')
        console.log "success on save"
        if savedTerm.get('isDeleted')
          @sendAction('deletedTerm', savedTerm, name, index)
        else
          @sendAction('savedTerm', savedTerm, name, index)
    )

  resetAllClick: ->
    @resetTerm()
  resetTerm: ->
    if @get('disabled') then return false
    # TODO : Handle
    term = @get('term')
    name = @get('name')
    index = @get('index')
    console.log "Handle reset of term"
    if term.get('id') then term.reload()
    else
      term.set('literalForm', '')
      term.set('roles', [])
      term.set('source', undefined)

  saveAllButton: Ember.inject.service()
  init: ->
    @_super()
    @get('saveAllButton').subscribe(@)
    @ensureLoadedRoles()

  loadingRoles: true
  ensureLoadedRoles: ->
    @set('loadingRoles', true)
    roles = @get('roles')
    unless roles
      @set('loadingRoles', false)
      return
    if roles.then
      roles.then () =>
        @set('loadingRoles', false)
    else @set('loadingRoles', false)

  actions:
    selectSuggestion: (suggestion) ->
      if @get('disabled') then return false
      @set('term.literalForm', "#{@get('term.literalForm')}#{suggestion}")
    focusTerm: (bool) ->
      @set('focused', bool)
      if @get('disabled') then return false
      if bool is false
        @parseRolesFromString(@get('term'))
    toggleGender: (term, role) ->
      if @get('disabled') then return false
      name = @get('name')
      index = @get('index')
      @sendAction('toggleGender', term, role, name, index)
    saveTerm:  ->
      @saveTerm()
    resetTerm:  ->
      @resetTerm()
    deleteTerm: ->
      if @get('disabled') then return false
      term = @get('term')
      name = @get('name')
      index = @get('index')
      # TODO : Handle, maybe "grey out" the term
      console.log "Handle deletion of term"
      term.deleteRecord()

    focusInput: ->
      Ember.run.later =>
        @$('.input-box')?.children('input')?.focus()


`export default TermsItemComponent`
