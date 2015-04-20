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
end
