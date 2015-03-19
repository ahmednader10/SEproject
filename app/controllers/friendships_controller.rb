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
@friendship1 = Friendship.new(:user_id => @user.id , :friend_id => @friend.id,  :requesting => @friend.username)
  @friendship2 = Friendship.new(:friend_id => @user.id , :user_id => @friend.id ,  :pending => @user.username)



  if @friendship1.save && @friendship2.save
    flash[:success] = "Added friend."
    redirect_to users_path
  else
    flash[:error] = "Unable to add friend."
    redirect_to friendships_path
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



