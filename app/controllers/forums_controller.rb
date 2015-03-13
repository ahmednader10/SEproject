class ForumsController < ApplicationController
	
	def index
		@forums = Forum.all
	end

	def show

		#check if memeber then enable editing 

		sleep 3
		@forum = Forum.find(params[:id])
	end

	def new
		@forum = Forum.new
	end

	def create
  		@forum = Forum.new(forum_params)
 
  		if @forum.save
  			redirect_to(created_path(@forum))
  		else
  			render 'new'
  		end
	end

	def created
		@forum = Forum.find(params[:id])
	end

	def join_forum
	#	@user = User.find(session[:user_id])
	#	@user = User.find(1)
	#			params[:user][:forum_ids] ||= []
  	#		if @user.update_attributes(params[:user])
     # 			flash[:notice]='Joined Forum Successfully!'
  	#			redirect_to :action => "show"
    # 		end  

     	#	@forum = Forum.find(params[:id])
		#	Membership.join!(@forum)

		@user = User.find(1)
		@forum = Forum.find(params[:id])


		#check if already joined

		membership = @forum.memberships.build(user: @user)
		membership.accept = true if @forum.privacy == '1'

		if membership.save
   		 flash[:notice] = 'Joined forum Successfully'
   		 redirect_to :action => "show"

   		 #send notification joined successfully
  		end

	end
 
private
  def forum_params
    params.require(:forum).permit(:title, :description, :privacy)
  end
end
