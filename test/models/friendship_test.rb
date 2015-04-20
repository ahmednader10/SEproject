require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)


  test "that creating a friendship works without raising an exception" do 
  	assert_nothing_raised do 
  	Friendship.create user: users(:raghda) , friend: users(:rowan)
  	end
  end


  test "that creating a friendship based on user id and friend id works" do 

  Friendship.create user_id: users(:raghda).id , friend_id: users(:rowan).id
  assert users(:raghda).friends.include?(users(:rowan))

  end

end
