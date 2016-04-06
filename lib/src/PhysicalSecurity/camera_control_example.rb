require_relative 'API/RESTMethods'
require_relative 'API/REST/CameraControl'
   # def self.doPTZ(token, p, t, z, priority, requestID=nil, securityToken)


params = {
  pan: 0,
  tilt: 0,
  zoom: 1,
  priority: 3,
  requestID: 4, 
  token: 4
}

uri = API::REST::CameraControl.do_ptz("token", "df", params)

puts uri