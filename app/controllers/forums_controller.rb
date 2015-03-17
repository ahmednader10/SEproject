
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

	def edit
		@forum = Forum.find(params[:id])
	end

	def create
  		@forum = Forum.new(forum_params)
  		@user = current_user

  		if @user == nil

			#flash[:notice] = 'You should login first'
   			redirect_to root_url
   		else
   			admin = @forum.admins.build(user: @user)

   			membership = @forum.memberships.build(user: @user)
   			if @forum.save && admin.save

  				membership.accept = true
  				membership.save

  				redirect_to(created_path(@forum))
  			else
  				render 'new'
  			end
   		end
	end


	def update
		@forum = Forum.find(params[:id])
		@user = current_user

		if @user == nil

			flash[:notice] = 'You should login first'

			# flash[:notice] = 'You should login first'
   			redirect_to root_url
   		else
   			admin = Admin.where({ forum_id: @forum.id, user_id: @user.id })
   			if !admin.empty? && @forum.update(forum_params)
				redirect_to(forums_path)
			else
				render 'edit'
			end
   		end
	end


	def destroy
		@forum = Forum.find(params[:id])
		@user = current_user

		if @user == nil
			redirect_to root_url
		else
			admin = Admin.where({ forum_id: @forum.id, user_id: @user.id })
			if !admin.empty?
				# confirm then delete
				@forum.destroy
				redirect_to forums_path
			else
				# refuse and redirect
				redirect_to forums_path
			end
		end
	end


	def created
		@forum = Forum.find(params[:id])
	end

	# join action enables logged in user to join public forums through clicking on the button 
	# "join Forum" and also enables logged in user to send request to join private forums and it checks 
	# if the user has already joined the forum before 

	def join_forum
	
		

		@user = current_user
		@forum = Forum.find(params[:id])


		
		if @user == nil

			 flash[:notice] = 'You should login first to be able to join forum'

   		 redirect_to root_url
   		else
		membership = @forum.memberships.build(user: @user)
		membership.accept = true if @forum.privacy == '1'
		


		if  membership.save and membership.accept == true 
		  flash[:notice] = 'Successfully joined forum '
   		 render :action => "show"

   		
   		elsif !membership.save and membership.accept == true  
   				flash[:notice] = 'already member of this forum'
   				render :action => "show"

   		elsif !membership.save and membership.accept == nil  
   				flash[:notice] = 'already sent request to join this forum'
   				render :action => "show"

   		elsif membership.accept == nil
   				flash[:notice] = 'Pending request'
   				render :action => "show"

		end
		end
  		
  		#send notification joined successfully
	end
 
	  private
	  def forum_params
	    params.require(:forum).permit(:title, :description, :privacy)
	  end

end

