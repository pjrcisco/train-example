# https://10.10.20.69/ismserver/json/camerasettings?jsonDetails
# require_relative 'API/RESTMethods'

require_relative "API/REST/Authentication"
require_relative "API/REST/CameraSettings"

token = API::REST::Authentication.login("admin", "P@ssw0rd1")
settings = {
  "vendor"          => "Cisco Systems,Inc.",
  "model"           => "cisco-2500",
  "firmwareVersion" => "1.0.0.",
  "name"            => "n2ewtest-1500", #unique
  "description"     => "",
  "vsomUid"         => "testd1bc3b4ac-491a-4f35-bb9e-7598c13fbfff",
  "objectType"      => "vs_cameraSettings", 
  "uid"             => "testdc83e1fcf1-81ac-42f2-ab95-9fdac23afe2a" #unique
}
created_cam_settings = API::REST::CameraSettings.create_camera_settings(token, settings)
get_cam_settings     = API::REST::CameraSettings.get_camera_settings(token, created_cam_settings)
get_cam_settings[0]["description"] = "Hey this is a new description"
updated_cam_settings = API::REST::CameraSettings.update_camera_settings(token, get_cam_settings[0])
get_cam_settings     = API::REST::CameraSettings.get_camera_settings(token, updated_cam_settings)

example_settings = {
  refUid:         get_cam_settings[0]["uid"],
  refName:        get_cam_settings[0]["name"],
  refObjectType:  get_cam_settings[0]["objectType"],
  refVSOMUid:     get_cam_settings[0]["vsomUid"]
}

API::REST::CameraSettings.camera_settings_exist?(token, example_settings[:refName])
API::REST::CameraSettings.get_camera_settings_details(token, example_settings)
API::REST::CameraSettings.delete_camera_settings(token, example_settings)
API::REST::CameraSettings.camera_settings_exist?(token, example_settings[:refName])