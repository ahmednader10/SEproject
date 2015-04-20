require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  context "#create" do 
   context "when not logged in " do 
     should "redirect to the login page" do

     	get :create
     	assert_response :redirect

     end 


   end

	context "when logged in" do 
	#should "should set a flash error if the friend_id params is missing " do

         #get :create, {}
         #assert_equal "Friend required", flash[:notice]
	#end

	

	#should "display the friend's name " do

     #get :create , friend_id: users(:raghda).id
     #assert_match /#{users(:raghda).username}/, response.body


	#end 

	

	end 

end 
	

test "should show friendships" do
    assert_generates '/friendships/1', {controller: 'friendships', action: 'show', id: '1'}
  end

#test "should get index" do
    #get :index
    #assert_response :success
    #assert_not_nil assigns(:users)
  #end






#test "should route to accept friend request" do

	#assert_generates 'friendships/update' , {controller: 'friendships' , action: 'update'}
  
#end 





end 