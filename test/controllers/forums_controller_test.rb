require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
 test "should get destroy" do
 	user = User.create
 	session[:user_id] = user.id
    delete(:destroy, {'id' => "1"})
    assert_response :success
  end
end
