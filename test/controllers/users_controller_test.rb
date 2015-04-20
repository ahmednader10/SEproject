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

  # This test tries to create a user and then observes the change in the counter 
  # that keeps track of the users in the system. Moreover, the test makes sure
  # that the required redirection is successfully done.
  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {email: 'omar.hussein@gmail.com', password: '12345678', username: 'o_abouzaid', full_name: 'Omar Ashraf', gender: 'Male', 
        password_question: 'What is the name of your best friend?', answer_for_password_question: 'Hany'}
    end
    assert_redirected_to '/'
    post :create, user: {email: 'omar.hussein@gmail.com', password: '12345678', username: 'o_abouzaid', full_name: 'Omar Ashraf', gender: 'Male', 
        password_question: 'What is the name of your best friend?', answer_for_password_question: 'Hany'}
    assert_response :success
    assert_nil flash[:notice]
    assert_not_nil assigns(:user)
    assert_match session[:signin], "You have successfully signed up! You can now login."
  end

  # This test assures that the counter that keeps track of users won't be incremented
  # in case the user is not valid.
  test "should not create user" do
    assert_no_difference('User.count') do
      post :create, user: {email: 'omar.hussein@gmail.com', password: '1678', username: 'o_abouzaid', full_name: 'Omar Ashraf', gender: 'Male', 
        password_question: 'What is the name of your best friend?', answer_for_password_question: 'Hany'}
    end
    assert_response :success
  end

  test "should route to admin_join_forums_requests" do
      assert_generates 'users/join_requests', {controller: 'users' , action: 'admin_join_forums_requests'}
    end

  test "should show user" do
    assert_generates '/users/1', {controller: 'users', action: 'show', id: '1'}
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
