require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
	test "user/:user_id/notifications is working" do
		get :index
		assert_response :success
	end
end