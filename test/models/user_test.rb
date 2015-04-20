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

end
