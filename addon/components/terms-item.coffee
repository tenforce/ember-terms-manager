`import Ember from 'ember'`
`import layout from '../templates/components/terms-item'`

TermsItemComponent = Ember.Component.extend(
  layout: layout
  classNames: ['term']
  classNameBindings: ['focused:focus']

  # whether the source component should be displayed
  displaySource: true
  # whether changes are allowed
  disabled: false
  # whether shortcuts are disabled
  disableShortcuts: false

  # boolean to toggle / untoggle sources
  toggledSource: false

  actions:
    focusTerm: (bool) ->
      @set('focused', bool)
)

`export default TermsItemComponent`
