`import Ember from 'ember'`
`import layout from '../templates/components/terms-list'`

TermsListComponent = Ember.Component.extend(
  layout: layout
  classNames: ['block', 'list']
  classNameBindings: ['name']

  store: Ember.inject.service('store')

  # whether to show the source in items or not
  displaySource: true
  # whether to show the source in new item or not
  displayNewSource: true

  # whether a new term should be created or not
  displayNewTerm: true

  # whether we should display delete / suggestions for saved terms
  displayDelete: true
  displaySuggestions: false

  # whether we should display delete / suggestions for new term
  displayNewDelete: false
  displayNewSuggestions: true

  # placeholders, can be overriden
  placeholder: "e.g., \"actress//sf\" and confirm with ENTER"
  newPlaceholder: "e.g., \"actress//sf\" and confirm with ENTER"


  actions:
    toggleGender: (term, role, name, index) ->
      @sendAction('toggleGender', term, role, name, index)
    rollbackTerm: (term, name, index) ->
      @sendAction('rollbackTerm', term, name, index)
    saveTerm: (term, name, index) ->
      @sendAction('saveTerm', term, name, index)
    deleteTerm: (term, name, index) ->
      @sendAction('deleteTerm', term, name, index)
    saveNewTerm: (term, name, index) ->
      @sendAction('saveNewTerm', term, name, index)
)

`export default TermsListComponent`
