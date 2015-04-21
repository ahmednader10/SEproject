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

  # This test calls the action "userUnblocked" and passes an email
  # to be unblocked and ensures that the controller redirects to
  # the specified view
  test "should unblock user" do
    post :userUnblocked, {'unblock_user' => "omar.ashraf@gmail.com"}
    assert_redirected_to unblocked_path
    assert_not_nil assigns(:unblock)
  end


  test "should merge forums" do
    @forum1 = forums(:forum1)
    @forum2 = forums(:forum2)
    assert_difference('Forum.count', -1) do
      post(:createMerge, forum: {forum1_id: @forum1.id, forum2_id: @forum2.id, name: "title", description: "description"})
    end
    forum_merged = Forum.where(id: @forum1.id)
    assert_match forum_merged.first.title, "title"
    assert_match forum_merged.first.description, "description"
    assert_redirected_to '/sysadmins/index'
  end

  test "should not merge forum with itself" do
    @forum1 = forums(:forum1)
    @forum2 = forums(:forum1)
    post(:createMerge, forum: {forum1_id: @forum1.id, forum2_id: @forum2.id, name: "title", description: "description"})
    assert_equal "Can only merge different forums!", flash[:notice]
  end

  test "should not merge forums of different privacy setting" do
    @forum1 = forums(:forum1)
    @forum2 = forums(:forum3)
    post(:createMerge, forum: {forum1_id: @forum1.id, forum2_id: @forum2.id, name: "title", description: "description"})
    assert_equal "Can only merge forums of the same privacy setting!", flash[:notice]
  end
end
