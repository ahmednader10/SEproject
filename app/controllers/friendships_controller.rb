class FriendshipsController < ApplicationController


def show
 
  @friend = User.find(params[:id])

end 
def index
  @users= User.all
end 


def create 
@friendship1 = Friendship.new(:user_id => current_user.id , :friend_id => params[:friend_id] , :user_name => current_user.username , :friend_name => User.find_by(id: params[:friend_id]).username, :requesting => User.find_by(id: params[:friend_id]).username)
  @friendship2 = Friendship.new(:friend_id => current_user.id , :user_id => params[:friend_id] , :friend_name => current_user.username , :user_name => User.find_by(id: params[:friend_id]).username, :pending => current_user.username)



  if @friendship1.save && @friendship2.save
    flash[:success] = "Added friend."
    redirect_to users_path
  else
    flash[:error] = "Unable to add friend."
    redirect_to root_url
  end


  end
def update
@user = current_user
@userid= @user.id
@user2= Friendship.find(params[:id])
@friendid = @user2.friend_id

@friendship1 = Friendship.find_by( user_id: @userid,friend_id: @friendid)
@friendship2 = Friendship.find_by( user_id: @friendid, friend_id: @userid)

if @friendship1.update_attributes(:user_id => @userid, :friend_id => @friendid, :status => 1) && @friendship2.update_attributes(:user_id => @friendid, :friend_id => @userid, :status =>1 )
flash[:notice] = 'Friend sucessfully accepted!'
redirect_to friendships_path
else
redirect_to new_friendships_path
end
end 
def destroy

@friendship = current_user.friendships.find(params[:id]).destroy

redirect_to users_path
end
end




