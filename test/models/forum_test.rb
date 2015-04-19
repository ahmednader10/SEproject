require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save forum without title" do
  	forum = Forum.new
  	assert_not forum.save
  end
end
