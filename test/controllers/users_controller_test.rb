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


  test "should get delete" do
    get :delete
    assert_response :success
  end


  test "should show user" do
  assert_generates '/users/1', { controller: 'users', action: 'show', id: '1' }
  end

  test "should get profile"  do
    assert_generates 'users/profile/1', {controller: 'users' , action: 'profile', id:'1'}
  end


end
