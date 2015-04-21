require 'test_helper'

class NotificationsControllerTest < ActionController::TestCase

	def setup
		@notification = notifications(:one)
	end

	def teardown
		@notification = nil
	end
	
	test "should get notifications" do
		get :index
		assert_response :success, "Failed to get notifications"
	end

	test "should redirect to notifications" do
		assert_difference('Notification.count', difference = -1) do
			delete :destroy , id: @notification.id
		end
		assert_redirected_to '/notifications'
	end
	
end