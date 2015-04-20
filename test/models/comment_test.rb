require 'test_helper'

class CommentTest < ActiveSupport::TestCase
 def test_valid_comment
  	comment = comments(:complete_comment)
  	assert comment.valid?, comment.errors.full_messages.inspect
  end

  def test_missing_text
	comment = comments(:no_text)
  	assert !comment.valid?,"Can't save comment without a text"
  end
  
  def test_missing_user
	comment = comments(:no_user)
  	assert !comment.valid?,"comment must belong to a user"
  end

  def test_missing_idea
	comment = comments(:no_idea)
  	assert !comment.valid?,"comment must belong to an idea"
  end
end
