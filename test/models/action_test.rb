require 'test_helper'

class ActionTest < ActiveSupport::TestCase
	 test "action should not be saved without a user email" do
	 	action = Action.new
	 	assert_not action.save
	 end
end
