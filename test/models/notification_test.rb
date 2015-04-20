require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  
	test "notification should not be save without a user id" do
		notification = Notification.new
		assert_not notification.save, "Saved the notification without a referenced user"
	end

end
