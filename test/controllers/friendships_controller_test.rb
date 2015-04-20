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
	should "should set a flash error if the friend_id params is missing " do

         get :create 
         assert_equal "Friend Required " , flash[:notice]
	end

	
	end 

end 
	

end 
