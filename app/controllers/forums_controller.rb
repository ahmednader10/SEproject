class ForumsController < ApplicationController
	
	def index
		@forums = Forum.all
	end

	def show

		#check if memeber then enable editing 

		sleep 1
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

	# join action enables logged in user to join public forums through clicking on the button 
	# "join Forum" and also enables logged in user to send request to join private forums and it checks 
	# if the user has already joined the forum before 

	def join_forum
	


		@user = User.find(1)
		@forum = Forum.find(params[:id])


		#check if already joined

		membership = @forum.memberships.build(user: @user)
		membership.accept = true if @forum.privacy == '1'

		if  membership.save and membership.accept != nil 
		  flash[:notice] = 'Successfully joined forum '
   		 redirect_to :action => "show"

   		
   		elsif !membership.save  
   				flash[:notice] = 'already member of this forum'
   				redirect_to :action => "show"

   		elsif membership.accept == nil
   				flash[:notice] = 'Pending request'
   				redirect_to :action => "show"


		end
  		
  		#send notification joined successfully
	end
 
	private
	  def forum_params
	    params.require(:forum).permit(:title, :description, :privacy)
	  end
end
