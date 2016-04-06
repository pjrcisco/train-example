require_relative 'API/REST/Authentication'
require_relative 'API/REST/Location'
require_relative 'API/REST/DeviceTemplate'
require_relative 'API/REST/Camera'
require_relative 'API/REST/CameraBulkOps'
require_relative 'Resources/REST/References/BaseObjectRef'
require_relative 'Resources/DeviceTemplate'
require_relative 'API/REST/Server'
require_relative 'API/REST/Jobs'



token  = API::REST::Authentication.login("admin", "P@ssw0rd1")
filter = {
  "objectTypes": [],
  "depth": 0,
  "getLocalTreeOnly": false,
}
results  = API::REST::Location.get_tree(token, filter)
location = {
  "refUid": results["data"]["childGroups"][0]["uid"],
  "refName": results["data"]["childGroups"][0]["name"],
  "refObjectType": results["data"]["childGroups"][0]["objectType"],
  "refVsomUid": results["data"]["childGroups"][0]["vsomUid"]
} 

# getting a template that's associated with a device
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


for i in 0...camera_refs.size do 
  #puts "camera: #{i} #{camera_refs[i][:refName]}"
  #puts "=============="
  #puts "=============="
  #res = API::REST::Camera.get_camera_and_template_details(token, camera_refs[i])
  #puts JSON.pretty_generate(res)
end
#res = API::REST::Camera.get_camera_and_template_details(token, camera_refs[0])
#puts JSON.pretty_generate(res["data"]["deviceTemplate"])


template = Resources::DeviceTemplate.new({
  "name":"On Motion Template",
  "description":"A template for triggering get request on motion",
  "ownerLocationRef": location,
  "vsomUid": results["data"]["vsomUid"],
  "url":"http://riel.io"
})

#puts JSON.pretty_generate(template.to_hash)

#res = API::REST::DeviceTemplate.create(token, template.to_hash)
#puts res

#res = API::REST::CameraBulkOps.create_full_motion_windows(token, [camera_refs[0]] )
#puts JSON.pretty_generate(res)

#res = API::REST::CameraBulkOps.delete_cameras(token, [ camera_refs[1] ])
#puts JSON.pretty_generate(res)

res = API::REST::Server.get_servers(token)

our_server = res["data"]["items"][0]


ums_reference = {
  "refName": our_server["name"],
  "refVsomUid": our_server["vsomUid"],
  "refObjectType": our_server["objectType"],
  "refUid": our_server["uid"]
}

#res = API::REST::Server.discover_cameras(token, ums_reference)
#puts JSON.pretty_generate(res)

jobs_reference = {
    "refUid": "7d0517be-5e3b-422f-a83f-8eeb1bc7180a",
    "refName": "discoverCameras",
    "refObjectType": "vs_job",
    "refVsomUid": "dbc3b4ac-491a-4f35-bb9e-7598c13fbfff"
}
res = API::REST::Jobs.get(token, jobs_reference)
puts JSON.pretty_generate(res)