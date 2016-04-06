require_relative 'API/REST/Authentication'
require_relative 'API/REST/CameraRecordings'
require_relative 'API/REST/Camera'
require_relative 'API/REST/Jobs'


# the template for the camera must support on demand recording 
# for these examples to work

token   = API::REST::Authentication.login("admin", "P@ssw0rd1")

camera_list = API::REST::Camera.get_cameras(token)
camera_refs = []
i           = 0
camera_list["data"]["items"].each do |camera|
  camera_refs[i] = {
    "refUid": camera["alternateId"],
    "refName": camera["name"],
    "refObjectType": camera["objectType"],
    "refVsomUid": camera["vsomUid"]
  }
  i = i + 1
end

started = API::REST::CameraRecordings.start_on_demand(token, camera_refs[0])

puts "started"
puts "========"
puts JSON.pretty_generate(started)

sleep(5)

puts "stop"
puts "========"
stopped = API::REST::CameraRecordings.stop_on_demand(token, camera_refs[0])
puts JSON.pretty_generate(stopped)

#res = API::REST::CameraRecordings.get(token, camera_refs[0])
