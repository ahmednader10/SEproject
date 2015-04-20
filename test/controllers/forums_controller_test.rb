require 'test_helper'

class ForumsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should get index" do
  	get :index
  	assert_response :success
  	assert_not_nil assigns(:forums)
  end

  test "should get new" do
  	get :new
  	assert_response :success
  	assert_not_nil assigns(:forum)
  end

  test "should get edit" do
  	get(:edit, {'id' => "7"})
  	assert_response :success
  	assert_not_nil assigns(:forum)
  end

  test "should get created" do
  	get(:created, {'id' => "10"})
  	assert_response :success
  	assert_not_nil assigns(:forum)
  end

  test "should get show" do
  	get(:show, {'id' => "3"}, {'user_id' => "1"})
  	assert_response :success
  	assert_not_nil assigns(:forum)
  end

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

  test "should update forum" do
  	@forum = forums(:forum_update)
  	session[:user_id] = users(:user_with_valid_data).id
  	patch(:update, id: @forum, forum: {title: 'title_updated', description: 'description_updated', privacy: '2'})
  	forum_new = Forum.where(id: 70)
  	assert_match forum_new.first.title, "title_updated"
  	assert_match forum_new.first.description, "description_updated"
  	assert_match forum_new.first.privacy, "2"
  	assert_redirected_to forums_path
  end

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
 
  test "should get destroy" do
 #	user = User.create
 #	session[:user_id] = user.id
  #  delete(:destroy, {'id' => "1"})
  #  assert_response :success
  end

  test "should route to join forum" do
  		assert_generates 'forums/1/join', {controller: 'forums' , action: 'join_forum', id:'1'}
  end

  test "should route to show forum members" do
  	 	assert_generates 'forums/1/members', {controller: 'forums' , action: 'list_members', id:'1'}
  end

  test "should route to remove forum" do
  		assert_generates 'forums/1', {controller: 'forums' , action: 'destroy', id:'1'}
  end

  test "should route to remove member from forum" do
  		assert_generates 'forums/remove_member', {controller: 'forums' , action: 'remove_member'}
  end

  test "forum members not empty" do
  		get(:list_members, {'id'=>"1"})
  		assert_not_nil assigns(:users)
  end

  test "shouldn't join without login" do
  		get(:join_forum, {'id'=>"1"})
  		assert_equal 'You should login first to be able to join forum',flash[:notice]
  end


  
  test "should get join forum" do
	  	session[:user_id]= users(:user_with_valid_data).id
	  	get(:join_forum, {'id'=>"1"})
	  	assert_response :success
  end

  test "should get list of members" do
  		get(:list_members, {'id'=>"1"})
  		assert_response :success
  		assert_not_nil assigns(:users)
  end

  #test gives error
  test "should get remove member" do
  	#	get(:remove_member,{ 'id' => "1" },{'user_id'=>"1"})
  	#	assert_not_nil assigns(:membership1)
  end
end
