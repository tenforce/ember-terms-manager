`import Ember from 'ember'`
`import layout from '../templates/components/terms-list'`

TermsListComponent = Ember.Component.extend(
  layout: layout
  classNames: ['block']

  displaySource: true

  actions:
    toggleGender: (term, role, name) ->
      @sendAction('toggleGender', term, role, name)
)

`export default TermsListComponent`
