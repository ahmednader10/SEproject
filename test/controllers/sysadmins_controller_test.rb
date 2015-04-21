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

  # Tests merging two forums together.
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

  # Tests failure when trying to merge a forum with itself.
  test "should not merge forum with itself" do
    @forum1 = forums(:forum1)
    @forum2 = forums(:forum1)
    post(:createMerge, forum: {forum1_id: @forum1.id, forum2_id: @forum2.id, name: "title", description: "description"})
    assert_equal "Can only merge different forums!", flash[:notice]
  end

  # Tests failure when trying to merge two forums of different privacy setting. That is, a public forum with a private forum.
  test "should not merge forums of different privacy setting" do
    @forum1 = forums(:forum1)
    @forum2 = forums(:forum3)
    post(:createMerge, forum: {forum1_id: @forum1.id, forum2_id: @forum2.id, name: "title", description: "description"})
    assert_equal "Can only merge forums of the same privacy setting!", flash[:notice]
  end
end
