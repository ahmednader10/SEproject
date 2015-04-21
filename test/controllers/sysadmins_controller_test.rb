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

  # This test ensures that the "show" action is called successfully.
  test "should get show" do
    session[:sysadmin] = "true"
    post :show
    assert_response :success
  end

  # This test ensures that when given a wrong username and password
  # combination for the system admin, a re-direction for the right 
  # page occurs. Also, the error message appears.
  test "should not get show" do
    session[:sysadmin] = "tre"
    post :show, sysadmin: {username: "admin", password: "passord"}
    assert_redirected_to new_path
    assert_match flash[:notice], "Wrong email/password combination."
  end

  # This test ensures that when deleting a user with a valid email,
  # a re-direction to the right page occurs.
  test "should get edit" do
    get :edit, {'email_delete' => "omar.ashraf@gmail.com"}
    assert_not_nil assigns(:users)
    assert_not_nil assigns(:user_tmp)
    assert_redirected_to deleteUser_path
  end

  # This test ensures that whenever there is an error in the email
  # of the user to be deleted, the right page with the error message
  # appears.
  test "should not get edit" do
    get :edit, {'email_delete' => "omar.ashraf@gmail.co"}
    assert_nil assigns(:user_tmp)
    assert_redirected_to missingUser_path
  end

  # This test ensures that the delete action is called successfully.
  test "should get delete" do
    get :delete
    assert_response :success
  end

  # This test ensures that the "forums" action is called successfully.
  # Also, it nakes sure that the instance variable assigned there is not
  # nil.
  test "should get forums" do
    get :forums
    assert_response :success
    assert_not_nil assigns(:forums)
  end

  # This test calls the action "userBlocked" and passes an email
  # to be blocked.
  test "should block user" do
    post :userBlocked, {'block_user' => "omar.ashraf@gmail.com"}
    #assert_redirected_to blocked_path
    assert_not_nil assigns(:block)
  end

  # This test calls the action "userUnblocked" and passes an email
  # to be unblocked.
  test "should unblock user" do
    post :userUnblocked, {'unblock_user' => "omar.ashraf@gmail.com"}
    #assert_redirected_to unblocked_path
    assert_not_nil assigns(:unblock)
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
