`import { test, moduleForComponent } from 'ember-qunit'`
`import hbs from 'htmlbars-inline-precompile'`

moduleForComponent 'terms-item', 'Integration | Component | terms item', {
  integration: true
}

test 'it renders', (assert) ->
  assert.expect 2

  # Set any properties with @set 'myProperty', 'value'
  # Handle any actions with @on 'myAction', (val) ->

  @render hbs """{{terms-item}}"""

  assert.equal @$().text().trim(), ''

  # Template block usage:
  @render hbs """
    {{#terms-item}}
      template block text
    {{/terms-item}}
  """

  assert.equal @$().text().trim(), 'template block text'
