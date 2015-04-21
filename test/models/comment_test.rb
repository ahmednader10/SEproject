require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # checks that comment is valid if every required attribute is given
 def test_valid_comment
  	comment = comments(:complete_comment)
  	assert comment.valid?, comment.errors.full_messages.inspect
  end
# checks that comment is not valid if text doesnt exist
  def test_missing_text
	comment = comments(:no_text)
  	assert !comment.valid?,"Can't save comment without a text"
  end
  # check that comment is not vaild if userid is missing
  def test_missing_user
	comment = comments(:no_user)
  	assert !comment.valid?,"comment must belong to a user"
  end
# check that comment is not vaild if ideaid is missing 
  def test_missing_idea
	comment = comments(:no_idea)
  	assert !comment.valid?,"comment must belong to an idea"
  end
end
