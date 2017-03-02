`import Ember from 'ember'`
`import layout from '../templates/components/suggestions-list'`

SuggestionsListComponent = Ember.Component.extend
  layout: layout
  classNames:['translation-suggestions']

  actions:
    selectSuggestion: (translation) ->
      @sendAction('selectSuggestion', translation)

`export default SuggestionsListComponent`
