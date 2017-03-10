`import Ember from 'ember'`
`import layout from '../templates/components/term-suggestions'`

TermSuggestionsComponent = Ember.Component.extend(
  layout: layout

  tagName: ''
  #classNames: ['suggestions']

  tooltip: "See suggestions for this term"

  targetButtonId: Ember.computed 'buttonId', ->
    if @get('buttonId') then return "#"+@get('buttonId')
  # this dirty trick has to be done to make sure that the ID has been created and not confuse ember-tether dialog
  buttonLoaded: Ember.computed 'buttonId', ->
    if @get('buttonId') then return true
    else return false

  toggledSuggestions: false

  actions:
    toggleSuggestions: ->
      @toggleProperty('toggledSuggestions')
      if @get('toggledSuggestions')
        # nothing to do
      else
        @sendAction('closing')
    selectSuggestion: (translation) ->
      @sendAction('selectSuggestion', translation)
)

`export default TermSuggestionsComponent`
