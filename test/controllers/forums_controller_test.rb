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
end
