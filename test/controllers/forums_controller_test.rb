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


  
  test "should get join forum" do
	  	session[:user_id]= users(:user_with_valid_data).id
	  	get(:join_forum, {'id'=>"1"})
	  	assert_response :success
	  	assert_equal 'already member of this forum',flash[:notice]
  end

  test "should join forum" do
	  	session[:user_id]= users(:user_2).id
	  	get(:join_forum, {'id'=>"1"})
	  	assert_equal 'Successfully joined forum',flash[:notice]
  end

   test "should send request to join forum" do
	  	session[:user_id]= users(:user_2).id
	  	get(:join_forum, {'id'=>"2"})
	  	assert_equal 'Pending request',flash[:notice]
  end

  test "shouldn't send request to join forum 2 times" do
	  	session[:user_id]= users(:rowan).id
	  	get(:join_forum, {'id'=>"2"})
		assert_equal 'already sent request to join this forum',flash[:notice]
		assert_not_nil assigns(:membership)
  end


  test "should get list of members" do
  		get(:list_members, {'id'=>"1"})
  		assert_response :success
  		assert_not_nil assigns(:users)
  end

  #test gives error
  test "should get remove member" do
  	#	get(:remove_member,{ 'id' => "1" },{'user_id'=>"1"})
  	#	assert_not_nil assigns(:membership1)
  end
end
