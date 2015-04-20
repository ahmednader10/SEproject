require 'test_helper'

class SysadminsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

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
  #  current_user = users(:user_with_valid_data)
  #  session[:sysadmin] = "true"
  #  post :show, session[:sysadmin], current_user
  #  assert_response :success
  #end

  test "should get edit" do
    #session[:email] = "omar.ashraf@gmail.com"
    get :edit
    assert_response :success
    assert_not_nil assigns(:users)
    #assert_not_nil assigns(:user_tmp)
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
