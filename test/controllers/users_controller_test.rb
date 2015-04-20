require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end


  test "should get edit" do
   # get :edit
    #assert_response :success
  end


  test "should get delete" do
    get :delete
    assert_response :success
  end


  test "should get show" do
    #get :show
    #assert_response :success
  end

  test "should route to admin_join_forums_requests" do
      assert_generates 'users/join_requests', {controller: 'users' , action: 'admin_join_forums_requests'}
    end

  test "should show user" do
    assert_generates '/users/1', { controller: 'users', action: 'show', id: '1' }
  end

  test "should get profile"  do
    assert_generates 'users/profile/1', {controller: 'users' , action: 'profile', id:'1'}
  end

  test "should route to accept join request"  do
    assert_generates 'users/accept_join_request', {controller: 'users' , action: 'accept_join_request'}
  end

  test "shouldroute to reject join request"  do
    assert_generates 'users/reject_join_request', {controller: 'users' , action: 'reject_join_request'}
  end
end
