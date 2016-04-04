require 'test_helper'

class HelloWorldControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
  end
end
