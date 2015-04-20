require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
 
  test "should get destroy" do
 #	user = User.create
 #	session[:user_id] = user.id
  #  delete(:destroy, {'id' => "1"})
  #  assert_response :success
  end

  test "should route to join forum" do
  	assert_generates 'forums/1/join', {controller: 'forums' , action: 'join_forum', id:'1'}
  end

  test "should route to show forum members" do
  	assert_generates 'forums/1/members', {controller: 'forums' , action: 'list_members', id:'1'}
  end

  test "should route to remove forum" do
  	assert_generates 'forums/1', {controller: 'forums' , action: 'destroy', id:'1'}
  end

  test "should route to remove member from forum" do
  	assert_generates 'forums/remove_member', {controller: 'forums' , action: 'remove_member'}
  end

  test "forum members not empty" do
  	get(:list_members, {'id'=>"1"})
  	assert_not_nil assigns(:users)
  end

  test "shouldn't join without login" do
  	get(:join_forum, {'id'=>"1"})
  	assert_equal 'You should login first to be able to join forum',flash[:notice]
  end

end
