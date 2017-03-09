`import Ember from 'ember'`
`import layout from '../templates/components/terms-list'`

TermsListComponent = Ember.Component.extend(
  layout: layout
  classNames: ['block']

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


  actions:
    toggleGender: (term, role, name, index) ->
      @sendAction('toggleGender', term, role, name, index)
    savedTerm: (term, name, index) ->
      @sendAction('savedTerm', term, name, index)
    deletedTerm: (term, name, index) ->
      @sendAction('deletedTerm', term, name, index)
    savedNewTerm: (term, name, index) ->
      @sendAction('savedNewTerm', term, name, index)
)

`export default TermsListComponent`
