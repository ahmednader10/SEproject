class FriendshipsController < ApplicationController

def index
	@users=User.all 
end 
	
def create
  @friendship = Friendship.new(:user_id => current_user.id , :friend_id => params[:friend_id] , :user_name => current_user.username , :friend_name => User.find_by(id: params[:friend_id]).username)
  if @friendship.save
    flash[:notice] = "Added friend."
    redirect_to users_path
  else
    flash[:notice] = "Unable to add friend."
    redirect_to root_url
  end
end

def show 
	@users=User.all 
	@friendships=Friendship.all
end 

def destroy
  @friendship = current_user.friendships.find(params[:id])
  @friendship.destroy
  flash[:notice] = "Removed friendship."
  redirect_to users_path
end


end 