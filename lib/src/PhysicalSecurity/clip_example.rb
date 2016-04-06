require_relative 'API/REST/Authentication'
require_relative 'API/REST/Camera'
require_relative 'API/REST/Clip'

token   = API::REST::Authentication.login("admin", "P@ssw0rd1")
filter  = { "byExactName": "IPC-6400E-01" }
cameras = API::REST::Camera.get_cameras_filtered(token, filter)
c0      = cameras["data"]["items"][0]


clip_info = {
    "cameraRef":{
      "refUid"        => c0["uid"],
      "refName"       => c0["name"],
      "refObjectType" => c0["objectType"],
      "refVsomUid"    => c0["vsomUid"]
    },
    "serverRef":{
      "refUid"        => c0["managedByRef"]["refUid"],
      "refName"       => c0["managedByRef"]["refName"],
      "refObjectType" => c0["managedByRef"]["refObjectType"],
      "refVsomUid"    => c0["managedByRef"]["refVsomUid"],
    },
    "startTime"       => 230,
    "endTime"         => 3500,
    "name"            => "Clip_one.mp4",
    "description"     => "desc",
    "vsomUid"         => c0["vsomUid"],
    "objectType"      => "vs_clip_mp4"
}

results = API::REST::Clip.create(token, clip_info)
puts ""
puts "---------------------------------------------------"
puts "---------------------------------------------------"
puts ""
puts "uri --> clip/createClip "
puts ""
puts "---------------------------------------------------"
puts "---------------------------------------------------"
puts ""
puts JSON.pretty_generate(results)


