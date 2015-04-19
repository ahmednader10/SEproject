require 'test_helper'


class UserTest < ActiveSupport::TestCase
  def test_valid_user
  	user = users(:user_with_valid_data)
  	assert user.valid?, user.errors.full_messages.inspect
  end

  def test_empty_email
  	user = users(:user_without_an_email)
  	assert !user.valid?  
  end

  def test_short_password
  	user = users(:user_with_short_password)
  	assert !user.valid?
  end

  def test_empty_password
  	user = users(:user_with_no_password) 
  	assert !user.valid?
  end

  def test_empty_username
  	user = users(:user_with_no_username)
  	assert !user.valid?
  end

  def test_repeated_email
  	user = users(:user_with_repeated_email)
  	assert !user.valid?
  end

  def test_repeated_username
  	user = users(:user_with_repeated_username)
  	assert !user.valid?
  end

  #def test_password_confirmation

  #end

  def test_username_indentation
  	user = users(:user_with_invalid_username)
  	assert_match /\s/, user.username
  end

should have_many(:friendships)
should have_many(:friends)



end
