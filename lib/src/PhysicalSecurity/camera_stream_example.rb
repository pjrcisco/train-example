require_relative 'API/REST/Authentication'
require_relative 'API/REST/Camera'
require_relative 'API/REST/CameraControl'
require_relative 'API/REST/CameraSettings'
require_relative 'Utility/Methods'
require "json"

token = API::REST::Authentication.login("admin", "P@ssw0rd1")
urls  = []

camera_list = API::REST::Camera.get_cameras(token)

for i in 0...camera_list["data"]["items"].size
  id    = API::REST::Camera.get_camera_id(token, i)
  #urls << API::REST::Camera.get_streaming_details_url(token, id)
  urls << API::REST::Camera.get_streaming_details(token, id)
end

puts ""
puts "---------------------------------------------------"
puts "---------------------------------------------------"
puts ""
puts "uri --> camera/getStreamingDetails "
puts "this will return all the stream uri's for "
puts "for all cameras on the network     "
puts "that are accessible from camera/getCameras"
puts ""
puts "---------------------------------------------------"
puts "---------------------------------------------------"
puts ""

puts JSON.pretty_generate(urls)

#urls.each do |url|
#  puts Utility.swap_ip(url, Utility.ip)
#end

