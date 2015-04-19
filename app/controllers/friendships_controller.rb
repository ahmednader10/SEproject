class FriendshipsController < ApplicationController


def show
 
  @friend = User.find(params[:id])

end 
def index
  @users= User.all

end 


def create


@user = current_user
@friend = User.find( params[:friend_id])

@friendship1 = Friendship.new(:user_id => @user.id , :friend_id => @friend.id,  :requesting => @friend.username, :user_name => @user.username, :friend_name =>@friend.username, :status => 0)
 @friendship2=Friendship.new(:user_id => @friend.id , :friend_id => @user.id,  :pending => @user.username, :user_name => @friend.username, :friend_name =>@user.username, :status => 0)

Action.create(info: @user.username + ' has sent a friend request to ' + @friend.username, user_id: @user.id)

@friendship = Friendship.new(:user_id => @user.id , :friend_id => @friend.id,  :requesting => @friend.username, :user_name => @user.username, :friend_name =>@friend.username, :status => 0)




  if @friendship1.save && @friendship2.save
    flash[:success] = "Added friend."
    redirect_to users_path
  else
    flash[:error] = "Unable to add friend."
    redirect_to friendships_path
  end


  end
def update
@user = User.find(current_user)
@friend = Friendship.find( params[:id])

@friendship1 = Friendship.find_by( user_id: @user.id,friend_id: @friend.friend_id)
@friendship2 = Friendship.find_by( user_id: @friend.friend_id, friend_id: @user.id)

if @friendship1.update_attributes(:user_id => @user.id, :friend_id => @friend.user_id, :status => 1) && @friendship2.update_attributes(:user_id => @friend.user_id, :friend_id => @user.id, :status =>1 )
flash[:notice] = 'Friend sucessfully accepted!'
redirect_to friendships_path
else
redirect_to users_path
end
end 


def destroy

@friendship = current_user.friendships.find(params[:id]).destroy

redirect_to users_path
end
end



