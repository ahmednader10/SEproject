require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  
  # This test makes sure that the "index" action is called successfully
  # and also ensures that the "admins" variable is assigned accoordingly.
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admins)
  end

  # This test just makes sure that the "show" action is called succ-
  # essfully.
  test "should get show" do
    get :show
    assert_response :success
  end

  # This test makes sure that the action new is called successfully
  # and that the variables "forum" and "admin" are assigned correctly
  # according to the "new" action.
  test "should get new" do
    get(:new, {'forum_id' => "1"}, nil)
    assert_response :success
    assert_not_nil assigns(:forum)
    assert_not_nil assigns(:admin)
  end

  # This test just makes sure that the "edit" action is called succ-
  # essfully.
  test "should get edit" do
    get :edit
    assert_response :success
  end

  # This test just makes sure that the "delete" action is called succ-
  # essfully.
  test "should get delete" do
    get :delete
    assert_response :success
  end

  # This test makes sure that "create" action is called successfully and
  # that when an admin is added, a re-directions to a specific view occurs.
  test "should add admin" do
    @forum = forums(:forum_two)
    session[:sysadmin] = "true"
    post :create, forum_id: @forum, admin: {user: "omar.ashraf@gmail.com"}
    assert_redirected_to added_admin_path
  end

  # This test ensures that if the email is wrong, the correct page for displaying
  # an error appears.
  test "should not add admin" do
    @forum = forums(:forum_two)
    session[:sysadmin] = "true"
    post :create, forum_id: @forum, admin: {user: "omar.ashraf@gmail.co"}
    assert_redirected_to wrong_email_path
  end

end
