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

  # is-pending not working so we do it the old way
  loadingTermRoles: true
  checkLoadingTermRoles: Ember.observer('term.id', 'term.roles', ->
    @set 'loadingTermRoles', true
    if @get('term')
      @get('term.roles').then =>
        @set 'loadingTermRoles', false
  ).on('init')

  checkLoadingRoles: Ember.observer('roles', ->
    @set 'loadingRoles', true
    @get('roles')?.then =>
      @set 'loadingRoles', false
  ).on('init')

  actions:
    focusTerm: (bool) ->
      @set('focused', bool)
    toggleGender: (term, role, name) ->
      @sendAction('toggleGender', term, role, name)
    handleEnter: (term) ->
      #debugger
      # TODO : Handle
      console.log "Enter pressed"
)

`export default TermsItemComponent`
