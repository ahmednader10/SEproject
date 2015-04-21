require 'test_helper'

class SysadminsControllerTest < ActionController::TestCase
  
  # This test ensures that the action "new" is called successfully.
  test "should get new" do
    get :new
    assert_response :success
  end

  # This test ensures that the action "index" is called successfully.
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    session[:sysadmin] = "true"
    post :show, session[:sysadmin]
    assert_response :success
  end

  #test "should not get show" do
    #current_user = users(:user_with_short_password)
  #  #session[:sysadmin] = "true"
  #  post :show, {'user_id' => 1}
  #  assert_response :success
  #end

  test "should get edit" do
    get :edit, {'email_delete' => "omar.ashraf@gmail.com"}
    assert_not_nil assigns(:users)
    assert_not_nil assigns(:user_tmp)
    assert_redirected_to deleteUser_path
  end

  test "should not get edit" do
    get :edit
    assert_nil assigns(:user_tmp)
    assert_redirected_to missingUser_path
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get forums" do
    get :forums
    assert_response :success
    assert_not_nil assigns(:forums)
  end

  # This test calls the action "userBlocked" and passes an email
  # to be blocked and ensures that the controller redirects to
  # the specified view
  test "should block user" do
    post :userBlocked, {'block_user' => "omar.ashraf@gmail.com"}
    assert_redirected_to blocked_path
    assert_not_nil assigns(:block)
  end

  test "should unblock user" do
    #unblock_tmp = Block.new(email: "omar.ashraf@gmail.com")
    #post :userUnblocked, {'unblock_user' => "omar.ashraf@gmail.com"}
    #assert_redirected_to unblocked_path
    #assert_not_nil assigns(:user_to_be_unblocked)
  end

end
