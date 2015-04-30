class FriendshipsController < ApplicationController
before_action :authenticate_user, only: [:create]

#This method displays all the users and friendships in the system
def show
 @users= User.all
  @friend = User.find(params[:id])
  @friends = Friendship.all

end 

#This method displays current friends, the friend requests and the requested 
def index
  @users= User.all

end 

#This  ethod creates a friendship, a user adds a friend and it's saved in friendships table
def create

@user = current_user
@friend = User.find( params[:friend_id])

@friendship = Friendship.new(:user_id => @user.id , :friend_id => @friend.id,  :user_name => @user.username, :friend_name =>@friend.username, :status => 0, :requester => @user.username , :requested => @friend.username)


  Action.create(info: @user.username + ' has sent a friend request to ' + @friend.username, user_id: @user.id) 

  Notification.create(info: @user.username + ' has sent you a friend request.', user_id: @friend.id)


  if @friendship.save  
    flash[:success] = "Added friend."
    redirect_to root_path
  else
    flash[:error] = "Unable to add friend."
    redirect_to friendships_path
  
end
  end



  #This method is for accepting the friend request, the status is changed to true in the friendships table
def update
@user = User.find(current_user)
@friend = Friendship.find( params[:id])

@friendship = Friendship.find_by( user_id: @friend.user_id,friend_id: @user.id)
#@friendship2 = Friendship.find_by( user_id: @friend.friend_id,friend_id: @user.id)


if @friendship.update_attributes(user_id: @friend.user_id,friend_id: @user.id, status: 1) 
flash[:notice] = 'Friend sucessfully accepted!'
accepted = User.find(@friend.user_id)
Action.create(info: current_user.username + ' has accepted ' + accepted.username + "'s friend request.", user_id: @user.id)
Notification.create(info: current_user.username + ' has accepted your friend request.', user_id: accepted.id)
redirect_to friendships_path
else
redirect_to users_path
end
end 

#This method removes or deletes the friend request and removes the friendship from the table 
def destroy
  
@friendship = Friendship.find(params[:id]).destroy

redirect_to root_path
end


#this method checks that the user is currently logged in 
def authenticate_user

    if current_user == nil
      redirect_to login_path

    end

if current_user != nil
flash[:success]= "Successfully logged in "
end 
  end
end



