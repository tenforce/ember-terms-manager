`import Ember from 'ember'`
`import layout from '../templates/components/terms-item'`

TermsItemComponent = Ember.Component.extend(
  layout: layout
  classNames: ['term']
  classNameBindings: ['focused:focus', 'dirty', 'term.isDeleted:deleted', 'term.isNew:new']

  # whether changes are allowed
  disabled: false
  # whether shortcuts are disabled
  disableShortcuts: false
  # whether the delete button should be disabled
  disableDelete: false

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


  actions:
    selectSuggestion: (suggestion) ->
      @set('term.literalForm', "#{@get('term.literalForm')}#{suggestion}")
    focusTerm: (bool) ->
      @set('focused', bool)
    toggleGender: (term, role) ->
      name = @get('name')
      index = @get('index')
      @sendAction('toggleGender', term, role, name, index)
    saveTerm:  ->
      # TODO : Handle
      term = @get('term')
      name = @get('name')
      index = @get('index')
      console.log "Handle saving of term"
      if @get('disabled') then return false
      term.save().then( (savedTerm) =>
        unless @get('isDestroyed')
          console.log "success on save"
          @set('saveStatus', "success")
          if savedTerm.get('isDeleted')
            @sendAction('deletedTerm', savedTerm, name, index)
          else
            @sendAction('savedTerm', savedTerm, name, index)
      ).catch( (error) =>
        console.log "model failure on save"
        unless @get('isDestroyed')
          @set('saveStatus', "failure")
        throw error
      )
    resetTerm:  ->
      # TODO : Handle
      term = @get('term')
      name = @get('name')
      index = @get('index')
      console.log "Handle reset of term"
      if @get('disabled') then return false
      term.reload()
      #term.reload().then (newterm) =>
        #@set('term', newterm)
    deleteTerm: ->
      term = @get('term')
      name = @get('name')
      index = @get('index')
      # TODO : Handle, maybe "grey out" the term
      console.log "Handle deletion of term"
      if @get('disabled') then return false
      term.deleteRecord()

)

`export default TermsItemComponent`
