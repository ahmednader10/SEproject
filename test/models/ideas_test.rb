require 'test_helper'

class IdeasTest < ActiveSupport::TestCase
 def test_valid_idea
  	idea = ideas(:complete_idea)
  	assert idea.valid?, idea.errors.full_messages.inspect
  end

  def test_missing_body
	idea = ideas(:no_body)
  	assert !idea.valid?,"Can't save idea without a description"
  end

  def test_missing_user
	idea = ideas(:no_user)
  	assert !idea.valid?, idea.errors.full_messages.inspect
  end

  def test_missing_forum
	idea = ideas(:no_forum)
  	assert !idea.valid?, idea.errors.full_messages.inspect
  end
end