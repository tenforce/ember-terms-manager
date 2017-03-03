`import Ember from 'ember'`

# This function receives the params `params, hash`
termHasRole = (params, namedArgs) ->
  # this helper checks whether the term has the specified role
  term = namedArgs['term']
  role = namedArgs['role']
  unless term
    console.warn "no term passed as parameter to 'term-has-role' helper"
    return false
  unless role
    console.warn "no role passed as parameter to 'term-has-role' helper"
    return false
  res = term.get('roles')?.filter (item) ->
    if role.get('id') is item.get('id') then return true
    return false
  if res.get('length') > 0 then return true
  return false

TermHasRoleHelper = Ember.Helper.helper termHasRole

`export { termHasRole }`

`export default TermHasRoleHelper`
