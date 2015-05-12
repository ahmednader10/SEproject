class FriendshipsController < ApplicationController
before_action :authenticate_user, only: [:create]

#This method displays current friends, the friend requests and the requested 
def index
  @user = User.find(params[:user_id])
  friendships = Friendship.where(user_id: @user.id)
  friendships += Friendship.where(friend_id: @user.id)
  @friends = []
  @pending = []
  friendships.each do |friendship|
    if friendship.status == true
      if friendship.user_id == @user.id
        @friends += [User.find(friendship.friend_id)]
      else
        @friends += [User.find(friendship.user_id)]
      end
    elsif friendship.status == nil
      if friendship.user_id == @user.id
        @pending += [User.find(friendship.user_id)]
      end
    end
  end
end

def requests
  @user = User.find(params[:id])
  @requesters = Friendship.where(friend_id: @user.id)
end

#This  ethod creates a friendship, a user adds a friend and it's saved in friendships table
def create
  friend = User.find(params[:id])
  friendship = Friendship.new(user_id: current_user.id, friend_id: friend.id)
  friendship.save
  Action.create(info: current_user.username + ' has sent a friend request to ' + friend.username, user_email: current_user.email) 
  Notification.create(info: current_user.username + ' has sent you a friend request.', user_id: friend.id)
end

def accept
  friendship = Friendship.where(friend_id: current_user.id)
  firendship.update(status: true)
  redirect_to request.original_url
end

def reject
  friendship = Friendship.where(friend_id: current_user.id)
  friendship.update(status: false)
  redirect_to request.original_url
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

protected

def friendship_params
  params.require(:friendship).permit(:user_id, :friend_id)
end

end