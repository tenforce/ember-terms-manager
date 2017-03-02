`import Ember from 'ember'`
`import layout from '../templates/components/terms-item-source'`

TermsItemSourceComponent = Ember.Component.extend(
  layout: layout

  classNames: ['source']
  classNameBindings: ['emptySource:inactive:active']

  source: Ember.computed.alias 'term.source'
  emptySource: Ember.computed 'source', ->
    if @get('source.length') > 0 then return false
    return true
  tooltip: Ember.computed 'emptySource', ->
    if @get('emptySource') then return "Add a source for this term"
    else return "Modify source for this term"

  targetButtonId: Ember.computed 'buttonId', ->
    if @get('buttonId') then return "#"+@get('buttonId')
  # this dirty trick has to be done to make sure that the ID has been created and not confuse ember-tether dialog
  buttonLoaded: Ember.computed 'buttonId', ->
    if @get('buttonId') then return true
    else return false

  toggledSource: false

  actions:
    toggleSource: ->
      @toggleProperty('toggledSource')
      if @get('toggledSource')
        Ember.run.later =>
          $('.source-input')?[0]?.focus()
)

`export default TermsItemSourceComponent`
