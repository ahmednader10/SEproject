require 'test_helper'

class ForumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save forum without title" do
  	forum = forums(:forum_no_title)
  	assert_not forum.save
  end

  test "should save forum with title" do
  	forum = forums(:forum_title)
  	assert forum.save
  end

  test "should not save forum without privacy setting" do
  	forum = forums(:forum_no_privacy)
  	assert_not forum.save
  end

  test "should save forum with privacy setting" do
  	forum = forums(:forum_privacy)
  	assert forum.save
  end

  
end
