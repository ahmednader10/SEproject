require 'test_helper'

class IdeasTest < ActiveSupport::TestCase
#check that idea has all the required data to be valid
 def test_valid_idea
  	idea = ideas(:complete_idea)
  	assert idea.valid?, idea.errors.full_messages.inspect
  end
#checks that idea is not valid if text doesnt exist
  def test_missing_body
	idea = ideas(:no_body)
  	assert !idea.valid?,"Can't save idea without a description"
  end
#checks that idea is not valid if userid doesnt exist
  def test_missing_user
	idea = ideas(:no_user)
  	assert !idea.valid?, idea.errors.full_messages.inspect
  end
#checks that idea is not valid if forumid doesnt exist
  def test_missing_forum
	idea = ideas(:no_forum)
  	assert !idea.valid?, idea.errors.full_messages.inspect
  end
#checks that idea is not valid if title doesn't exist  
    def test_missing_title
  idea = ideas(:no_title)
    assert !idea.valid?, idea.errors.full_messages.inspect
  end
end