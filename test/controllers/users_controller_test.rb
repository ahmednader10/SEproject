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

  #test "should get edit" do
  #  get :edit
  #  assert_response :success
  #end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  #test "should get show" do
  #  get :show
  #  assert_response :success
  #end

end
