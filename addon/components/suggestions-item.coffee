`import Ember from 'ember'`
`import layout from '../templates/components/suggestions-item'`

SuggestionsItemComponent = Ember.Component.extend
  layout: layout
  classNames:['translation-suggestion']
  collapsed: true
  actions:
    selectSuggestion: (translation) ->
      @sendAction('selectSuggestion', translation)
    toggleCollapsed:  ->
      @toggleProperty("collapsed")

`export default SuggestionsItemComponent`
