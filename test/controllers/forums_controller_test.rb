require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
 
  test "should get destroy" do
 #	user = User.create
 #	session[:user_id] = user.id
  #  delete(:destroy, {'id' => "1"})
  #  assert_response :success
  end

  test "should join forum" do
  	assert_generates 'forums/1/join', {controller: 'forums' , action: 'join_forum', id:'1'}
  end

  test "should show forum members" do
  	assert_generates 'forums/1/members', {controller: 'forums' , action: 'list_members', id:'1'}
  end

  test "should remove forum" do
  	assert_generates 'forums/1', {controller: 'forums' , action: 'destroy', id:'1'}
  end

  test "should remove member from forum" do
  	assert_generates 'forums/remove_member', {controller: 'forums' , action: 'remove_member'}
  end
end
