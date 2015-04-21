require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  #context "#create" do 
   #context "when not logged in " do 
    # should "redirect to the login page" do

     #	get :create
     	#assert_response :redirect

     #end 


   #end

	#context "when logged in" do 
	#should "should set a flash error if the friend_id params is missing " do

         #get :create, {}
         #assert_equal "Friend required", flash[:notice]
	#end

	

	#should "display the friend's name " do

     #get :create , friend_id: users(:raghda).id
     #assert_match /#{users(:raghda).username}/, response.body


	#end 

	

	#end 

#end 
	


test "should show friendships" do
    assert_generates '/friendships/1', {controller: 'friendships', action: 'show', id: '1'}
  end



test "should get index" do 
	assert_generates '/friendships', {controller: 'friendships', action: 'index'}

end


test "should destroy friendship" do
	assert_generates '/friendships/1', {controller: 'friendships', action: 'destroy', id: '1'}
end




#test "should get index" do
    #get :index
    #assert_response :success
    #assert_not_nil assigns(:users)
  #end





#test "should get delete" do
#    get :destroy
#    assert_response :success
#  end

#test "should get index" do
#    get :index
#    assert_response :success
#    assert_not_nil assigns(:users)
#  end



#test "should create a friendship"  do 
	#assert_difference('Friendship.count') do
	#	post :create , friendship1: {user_id: 2 , friend_id: 3 ,  user_name: rowan, friend_name: raghda, :status => 0, requester: => rowan , requested: raghda} ,friendship2:{user_id: 3 ,friend_id:2 , user_name: raghda , requests: => rowan}
#end 
##assert_redirected_to users_path(assigns(:user))

#end



#test "should route to accept friend request" do

	#assert_generates 'friendships/update' , {controller: 'friendships' , action: 'update'}
  
#end 





end 
