`import Ember from 'ember'`
`import layout from 'terms-manager/templates/components/term-list'`

TermListComponent = Ember.Component.extend(
  store: Ember.inject.service('store')
  layout:layout

  removePrefTerm: (term, index) ->
    if index is 0
      Ember.run.next =>
        @$('.tabbable')[1]?.focus()
    else
      unless index is "new"
        index = +index-1
        @$(".tabbable")[index]?.focus()
    @get('prefTerms').removeObject(term)
    term.destroyRecord()


  newField: false

  tooManyPrefTerms: Ember.computed 'prefTerms.length', ->
    return @get('prefTerms.length') > 1

  actions:
    showNewField: ->
      @toggleProperty('newField')

    removePrefTerm: (term, index) ->
      @removePrefTerm(term, index)
)

`export default TermListComponent`
