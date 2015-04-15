
class ForumsController < ApplicationController
	
	# Views all forums showing their title and description.
	def index
		@forums = Forum.all
	end

	# Views a specific forum. Users can post ideas here.
	def show

		#check if memeber then enable editing 

		sleep 1
		@forum = Forum.find(params[:id])
	end

	# Renders the page for creating a forum.
	def new
		@forum = Forum.new
	end

	# Renders the page for editing a forum.
	def edit
		@forum = Forum.find(params[:id])
	end

	# Creates a forum and saves it in the database. Also here is where making a user an admin is handled.
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

	# Updates the record of the forum in the database with the new data, and makes sure this is only done by the admin
	# of the forum.
	def update
		@forum = Forum.find(params[:id])
		@user = current_user
		if session[:sysadmin] && @forum.update(forum_params)
			redirect_to(forums_sysadmins_path) and return
		end
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

	# Deletes a forum, and makes sure that a forum is only deleted by its admin.
	def destroy
		@forum = Forum.find(params[:id])
		@user = current_user
		if session[:sysadmin]
			@forum.destroy
			redirect_to forums_sysadmins_path and return
		end
		if @user == nil
			redirect_to root_url
		else
			admin = Admin.where({ forum_id: @forum.id, user_id: @user.id })
			if !admin.empty? 
				# confirm then delete
				@forum.destroy
				# admin.destroy
				redirect_to forums_path
			else
				# refuse and redirect
				redirect_to forums_path
			end
		end
	end

	# A temporary page that shows up after creating a forum. Only notifies the user that the forum has been created.
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
 
 	# Strong parameters
	  private
	  def forum_params
	    params.require(:forum).permit(:title, :description, :privacy)
	  end

end

