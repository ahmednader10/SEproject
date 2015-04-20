class IdeasController < ApplicationController
	before_action :authenticate_user, only: [:create, :like, :report]
	before_action :check_forum_not_joined, only: :new

	#index method list all the idea titles related to a forum.
	def index
		@ideas = Idea.where(forum_id: params[:forum_id])
	end
	
	#show method showes the title and text of a chosen idea.
	def show
		@forum = Forum.find(params[:forum_id])
		 @idea = Idea.find(params[:id])
		 @comment = Comment.new
	end

	def new

		@forum = Forum.find(params[:forum_id])
		@idea = Idea.new

	end

	# a method that enables the forum admin to delete any idea written by any member in his forum
	def destroy
		@idea = Idea.find(params[:id])
		@forum = Forum.find(params[:forum_id])
		if current_user != nil
			if current_user != User.find(@idea.user_id)
				Action.create(info: current_user.username + ' has deleted an idea: (' + @idea.title + ') belonging to user: (' + User.find(@idea.user_id).username + ') located in forum: (' + @forum.title + ').', user_id: current_user.id)
			else
				Action.create(info: current_user.username + ' has deleted his idea: (' + @idea.title + ') located in forum: (' + @forum.title + ').', user_id: current_user.id)
			end
		else
			Action.create(info: 'A system admin has deleted an idea: (' + @idea.title + ') belonging to user: (' + User.find(@idea.user_id).username + ') located in forum: (' + @forum.title + ').', user_id: -1)
		end
		@idea.destroy
		redirect_to forum_path(@forum)
	end


   #enables the user to create an idea by adding a title and text.
	def create

		# @idea = Idea.new(idea_params)
		# @idea.forum = @forum
		@idea = @forum.ideas.build(idea_params)
		@idea.user = current_user

		if @idea.save

			Action.create(info: current_user.username + ' has posted a new idea: (' + @idea.title + ') on forum: (' + Forum.find(@idea.forum_id).title + ').', user_id: current_user.id)

			# This block of code sends a notification to the admins of the forum being posted on
			# =================================================================
			admins = Admin.where(forum_id: @forum)	
			admins.each do |admin|
				Notification.create(info: (current_user.username + " has posted an idea (" + @idea.title + ") a forum that you administrate (" + @forum.title + ")."), seen: false, user_id: admin.user_id)
			end
			# =================================================================

			redirect_to @forum
		else

			render action: :new

		end
	end

	#def not_joined_forum
	#end

	# used to enable the user of the current secession to like an idea
	def like
		@forum = Forum.find(params[:forum_id])
		@user = current_user
		@idea = Idea.find(params[:id])
		@user= User.find_by(:id => @idea.user_id)

		if (@user.bfriends.include?(current_user))

		else

	 	@likeidea = Likeidea.new(:user_id => @user.id , :idea_id => @idea.id)
		end
		if @likeidea.save
			Action.create(info: @user.username + ' has liked an idea: (' + @idea.title + ') belonging to user: (' + User.find(@idea.user_id).username + ') located in forum: (' + @forum.title + ').', user_id: @user.id)
	   		flash[:notice] = "Idea Liked!"
		else
			flash[:notice] = "You've already liked this idea!"
		end

      	redirect_to forum_idea_path(@forum, @idea) # [@forum, @idea]
	end
	# allows user to report an idea
	def report
		@forum = Forum.find(params[:forum_id])
		@user = current_user
		@idea = Idea.find(params[:id])

	 	@reportidea = Reportidea.new(:user_id => @user.id , :idea_id => @idea.id)

        if @idea.user_id == @user.id
	 	flash[:notice] = "Cannot report your own idea!"
		elsif @reportidea.save
			Action.create(info: @user.username + ' has reported an idea: (' + @idea.title + ') belonging to user: (' + User.find(@idea.user_id).username + ') located in forum: (' + @forum.title + ').', user_id: @user.id)
	   		flash[:notice] = "Idea has been reported!"
		else
			flash[:notice] = "You've already reported this idea!"
		end

      	redirect_to forum_idea_path(@forum, @idea) # [@forum, @idea]
	end

 # used to allow the user to enter the information needed from him and nothing more inorder not to be able to change the model
  protected
	def idea_params
		params.require(:idea).permit(:title, :text)
	end
# used to check that there's a current user to be able to use the above actions
	def authenticate_user
		@forum = Forum.find(params[:forum_id])

		if current_user == nil
			redirect_to @forum

		Membership.where(user_id: current_user.id , forum_id: @forum.id, accept: !true).empty?
			render action: :not_joined_forum
		end

	end

	def check_forum_not_joined
		@forum = Forum.find(params[:forum_id])
			if current_user != nil and Membership.where(user_id: current_user.id , forum_id: @forum.id, accept: true).empty?
			render action: :not_joined_forum
		end
	end
end