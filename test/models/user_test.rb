require 'test_helper'


class UserTest < ActiveSupport::TestCase
  
  # Testing that a given user is valid
  def test_valid_user
  	user = users(:user_with_valid_data)
  	assert user.valid?, user.errors.full_messages.inspect
  end

  # Testing that a user with no email would not be valid.
  def test_empty_email
  	user = users(:user_without_an_email)
  	assert !user.valid?  
  end

  # Testing that a user with password less than the min required will not be valid.
  def test_short_password
  	user = users(:user_with_short_password)
  	assert !user.valid?
  end

  # Testing that a user with no password will not be valid.
  def test_empty_password
  	user = users(:user_with_no_password) 
  	assert !user.valid?
  end

  # Testing that a user with no username will not be valid.
  def test_empty_username
  	user = users(:user_with_no_username)
  	assert !user.valid?
  end

  # Testing that a user with a repeated email will not be valid.
  def test_repeated_email
  	user = users(:user_with_repeated_email)
  	assert !user.valid?
  end

  # Testing that a user with a repeated username will not be valid.
  def test_repeated_username
  	user = users(:user_with_repeated_username)
  	assert !user.valid?
  end

  # Testing that a user with wrong indentation in the username will not be valid.
  def test_username_indentation
  	user = users(:user_with_invalid_username)
  	assert_match /\s/, user.username
  end



should have_many(:friendships)
should have_many(:friends)

  
test "that no error is raised when trying to access a friend list" do 

  assert_nothing_raised do
    user= users(:raghda)
    user.friends
end
end
test "that creating friendships on a user works" do 
 users(:raghda).friends << users(:rowan)
 users(:raghda).friends.reload
 assert users(:raghda).friends.include?(users(:rowan))
 end

  #def test_show
  #  user = users(:miada)
  #  get user_url(user)
  #  assert_response :success
  #  assert_select "h1" , user.username
  #end


end
