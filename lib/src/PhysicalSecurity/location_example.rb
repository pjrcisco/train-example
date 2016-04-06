require_relative 'API/REST/Authentication'
require_relative 'API/REST/Location'

token  = API::REST::Authentication.login("admin", "P@ssw0rd1")
filter = {
  "objectTypes": [],
  "depth": 0,
  "getLocalTreeOnly": false,
}

results = API::REST::Location.get_tree(token, filter)
puts ""
puts "---------------------------------------------------"
puts "---------------------------------------------------"
puts ""
puts "uri --> location/getLocationTree "
puts "Given a treeFilter, returns the location hierarchy"
puts ""
puts "---------------------------------------------------"
puts "---------------------------------------------------"
puts ""
puts JSON.pretty_generate(results)