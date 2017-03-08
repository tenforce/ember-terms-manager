`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'term-suggestions', 'Integration | Component | term suggestions', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{term-suggestions}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#term-suggestions}}
      template block text
    {{/term-suggestions}}
  """

  assert.equal @$().text().trim(), 'template block text'
