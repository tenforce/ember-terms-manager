`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'term-source', 'Integration | Component | term source', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{term-source}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#term-source}}
      template block text
    {{/term-source}}
  """

  assert.equal @$().text().trim(), 'template block text'
