require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  # Tests fetching the /forums/index page.
  test "should get index" do
  	get :index
  	assert_response :success
  	assert_not_nil assigns(:forums)
  end

  # Tests fetching the /forums/new page.
  test "should get new" do
  	get :new
  	assert_response :success
  	assert_not_nil assigns(:forum)
  end

  # Tests fetching the forums/edit/:id page.
  test "should get edit" do
  	get(:edit, {'id' => "7"})
  	assert_response :success
  	assert_not_nil assigns(:forum)
  end

  # Tests fetching the forums/created/:id page.
  test "should get created" do
  	get(:created, {'id' => "10"})
  	assert_response :success
  	assert_not_nil assigns(:forum)
  end

  # Tests fetching the forums/show/:id page of a particular forum.
  test "should get show" do
  	get(:show, {'id' => "3"}, {'user_id' => "1"})
  	assert_response :success
  	assert_not_nil assigns(:forum)
  end

  # Tests creating a forum and the assignment of an admin to it.
  test "should create forum" do
  	assert_difference('Forum.count') do
  		assert_difference('Admin.count') do
  			assert_difference('Membership.count') do
  				session[:user_id] = users(:user_with_valid_data).id
  				post(:create, forum: {title: 'title', description: 'description', privacy: '1'})
  			end
  		end
  	end
  	assert_redirected_to created_path(assigns(:forum))
  end

  # Tests updating a forum.
  test "should update forum" do
  	@forum = forums(:forum_update)
  	session[:user_id] = users(:user_with_valid_data).id
  	patch(:update, id: @forum, forum: {title: 'title_updated', description: 'description_updated', privacy: '2'})
  	forum_new = Forum.where(id: @forum.id)
  	assert_match forum_new.first.title, "title_updated"
  	assert_match forum_new.first.description, "description_updated"
  	assert_match forum_new.first.privacy, "2"
  	assert_redirected_to forums_path
  end

  # Tests deleting a forum.
  test "should delete forum" do
  	@forum = forums(:forum_delete)
  	session[:user_id] = users(:user_with_valid_data).id
  	assert_difference('Forum.count', -1) do
  		assert_difference('Admin.count', -1) do
  			assert_difference('Membership.count', -1) do
  				delete(:destroy, id: @forum)
  			end
  		end
  	end
  	assert_redirected_to forums_path
  end
 
  #tests the correct route when requesting join a forum
  test "should route to join forum" do
  		assert_generates 'forums/1/join', {controller: 'forums' , action: 'join_forum', id:'1'}
  end

  #tests the correct route to show a forum's members
  test "should route to show forum members" do
  	 	assert_generates 'forums/1/members', {controller: 'forums' , action: 'list_members', id:'1'}
  end

  #tests the correct route when an admin deletes his forum
  test "should route to remove forum" do
  		assert_generates 'forums/1', {controller: 'forums' , action: 'destroy', id:'1'}
  end

  #test the correct route to remove a member from a forum by its admin
  test "should route to remove member from forum" do
  		assert_generates 'forums/remove_member', {controller: 'forums' , action: 'remove_member'}
  end

  #tests that the list of members of a forum is not empty
  test "forum members not empty" do
  		get(:list_members, {'id'=>"1"})
  		assert_not_nil assigns(:users)
  end

  #tests that a user can't join a forum when not logged in
  test "shouldn't join without login" do
  		get(:join_forum, {'id'=>"1"})
  		assert_equal 'You should login first to be able to join forum',flash[:notice]
  end


  #tests that a user can't request to join a forum more than once until receiving response
  test "should get join forum" do
	  	session[:user_id]= users(:user_with_valid_data).id
	  	get(:join_forum, {'id'=>"1"})
	  	assert_response :success
	  	assert_equal 'already member of this forum',flash[:notice]
  end

  #tests that a user can successfully join a forum
  test "should join forum" do
	  	session[:user_id]= users(:user_2).id
	  	get(:join_forum, {'id'=>"1"})
	  	assert_equal 'Successfully joined forum',flash[:notice]
  end

  #tests that a pending request is generated  correctly when a user requests to join a private forum
   test "should send request to join forum" do
	  	session[:user_id]= users(:user_2).id
	  	get(:join_forum, {'id'=>"2"})
	  	assert_equal 'Pending request',flash[:notice]
  end

  #tests that a user can't request to join a private forum more than once until receiving a response
  test "shouldn't send request to join forum 2 times" do
	  	session[:user_id]= users(:rowan).id
	  	get(:join_forum, {'id'=>"2"})
		assert_equal 'already sent request to join this forum',flash[:notice]
		assert_not_nil assigns(:membership)
  end

  #test checks that showing a list of forum members was successful
  test "should get list of members" do
  		get(:list_members, {'id'=>"1"})
  		assert_response :success
  	end
end
