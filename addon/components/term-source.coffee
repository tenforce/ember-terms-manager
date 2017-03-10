`import Ember from 'ember'`
`import layout from '../templates/components/term-source'`

TermSourceComponent = Ember.Component.extend(
  layout: layout

  classNames: ['source']
  classNameBindings: ['emptySource:inactive:active']

  source: Ember.computed 'term.source',
    get: (key) ->
      @get('term.source')
    set: (key, value) ->
      if value is "" then value = undefined
      @set('term.source', value)
      return value
  emptySource: Ember.computed 'source', ->
    if @get('source.length') > 0 then return false
    return true
  tooltip: Ember.computed 'emptySource', ->
    if @get('disabled') then return "See source for this term"
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
      if @get('disabled') then return false
      if @get('toggledSource')
        Ember.run.later =>
          $('.source-input')?[0]?.focus()
      else
        @sendAction('closing')
)

`export default TermSourceComponent`
