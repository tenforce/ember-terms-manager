`import Ember from 'ember'`
`import layout from '../templates/components/suggestions-list'`

SuggestionsListComponent = Ember.Component.extend
  layout: layout
  classNames:['translation-suggestions']
  classNameBindings: ['emptySuggestions:empty']

  emptySuggestions: Ember.computed 'suggestions', ->
    return @get('suggestions.length') is 0

  actions:
    selectSuggestion: (translation) ->
      @sendAction('selectSuggestion', translation)

`export default SuggestionsListComponent`
