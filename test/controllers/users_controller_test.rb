require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  # This test checks that a request to "index" action was successful and also makes sure
  # that the variable "users" has some data since the controller do so to this variable.
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  # This test checks that a request to "new" action was successful and also makes sure
  # that the variable "user" is not equal to nil, since it was assigned a value in the 
  # "new" action.
  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:user)
  end

  # This test just makes sure that the "delete" action was called successfully.
  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {email: 'omar.hussein@gmail.com', password: '12345678', username: 'o_abouzaid', full_name: 'Omar Ashraf', gender: 'Male', 
      password_question: 'What is the name of your best friend?', answer_for_password_question: 'Hany'}
    end
    #assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    assert_generates '/users/1', {controller: 'users', action: 'show', id: '1'}
  end

  test "should get profile"  do
    assert_generates 'users/profile/1', {controller: 'users' , action: 'profile', id:'1'}
  end


end
