`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'terms-item-source', 'Integration | Component | terms item source', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{terms-item-source}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#terms-item-source}}
      template block text
    {{/terms-item-source}}
  """

  assert.equal @$().text().trim(), 'template block text'
