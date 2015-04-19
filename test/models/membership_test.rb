require 'test_helper'


class MembershipTest < ActiveSupport::TestCase
  #def test_valid_user
  #	user = users(:user_with_valid_data)
  #	assert user.valid?, user.errors.full_messages.inspect
  #end

  def test_duplicate_memberships
  	membership1 = memberships(:one)
  	membership2 = memberships(:two)
  	assert !membership2.valid?,"can't join same forum multiple times"
  end

  def test_different_memberships
  	membership1 = memberships(:one)
  	membership2 = memberships(:three)
  	assert membership2.valid?,"can't join different forums"
  end
end