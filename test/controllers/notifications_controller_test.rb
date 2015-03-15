require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase
	test "notifications is working" do
		get :index
		assert_response :success
	end

	test ""
end