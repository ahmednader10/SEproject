require 'test_helper'


class UserTest < ActiveSupport::TestCase
  def test_valid_user
  	user = users(:user_with_valid_data)
  	assert user.valid?, user.errors.full_messages.inspect
  end
end
