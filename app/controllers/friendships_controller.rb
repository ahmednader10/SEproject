class FriendshipsController < ApplicationController
before_action :authenticate_user, only: [:create]


def show
 @users= User.all
  @friend = User.find(params[:id])
  @friends = Friendship.all

end 
def index
  @users= User.all

end 


def create

 


@user = current_user
@friend = User.find( params[:friend_id])

@friendship = Friendship.new(:user_id => @user.id , :friend_id => @friend.id,  :user_name => @user.username, :friend_name =>@friend.username, :status => 0, :requester => @user.username , :requested => @friend.username)


  Action.create(info: @user.username + ' has sent a friend request to ' + @friend.username, user_id: @user.id)
  #Noticfication.create(info: @user.username + ' has sent you a friend request.', user_id: @friend.id)


  if @friendship.save  
    flash[:success] = "Added friend."
    redirect_to root_path
  else
    flash[:error] = "Unable to add friend."
    redirect_to friendships_path
  
end
  end
def update
@user = User.find(current_user)
@friend = Friendship.find( params[:id])

@friendship = Friendship.find_by( user_id: @friend.user_id,friend_id: @user.id)
#@friendship2 = Friendship.find_by( user_id: @friend.friend_id,friend_id: @user.id)


if @friendship.update_attributes(user_id: @friend.user_id,friend_id: @user.id, status: 1) 
flash[:notice] = 'Friend sucessfully accepted!'
#Action.create(info: @user.username + ' has accepted ' + @friend.username + "'s friend request." + user_id: => @user.id)
#Notification.create(info: @user.username + ' has accepted your friend request.', user_id: => @friend.id)
redirect_to friendships_path
else
redirect_to users_path
end
end 


def destroy
  
@friend = Friendship.find(params[:id]).destroy

redirect_to root_path
end



def authenticate_user

    if current_user == nil
      redirect_to login_path

    end

if current_user != nil
flash[:success]= "Successfully logged in "
end 
  end
end



