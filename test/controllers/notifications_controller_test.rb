require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
	
	test "should get notifications" do
		get :index
		assert_response :success, "Failed to get notifications"
	end

	test "should redirect to notifications" do
		delete :destroy
		assert_redirected_to (controller: "notifications", action: "index")
	end
	
end