require 'src/Utility/Response'
require 'src/Tropo/Execute'
class CameraEvent < ActiveRecord::Base

  def self.handle(camera_params)
    if valid_token?(camera_params[:token])
      Tropo.execute(camera_params)
    else
      Utility::Response.new({
        "error": "invalid token"
      })
    end
  end


  private

  def self.valid_token?(token)
    if token.to_s == ENV["CAM_TOKEN"]
      true
    else
      false
    end
  end

end
