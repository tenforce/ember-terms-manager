`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'test-test-test', 'Integration | Component | test test test', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{test-test-test}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#test-test-test}}
      template block text
    {{/test-test-test}}
  """

  assert.equal @$().text().trim(), 'template block text'
