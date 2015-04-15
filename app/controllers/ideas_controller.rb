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


   #enables the user to create an idea by adding a title and text.
	def create

		# @idea = Idea.new(idea_params)
		# @idea.forum = @forum
		@idea = @forum.ideas.build(idea_params)
		@idea.user = current_user

		if @idea.save

			# This block of code sends a notification to the admins of the forum being posted on
			# =================================================================
			admins = Admin.where(forum_id: @forum)	
			admins.each do |admin|
				Notification.create(info: (current_user.username + ' has posted on a forum that you administrate (' + @forum.title + ').'), seen: false, user_id: admin.user_id)
			end
			# =================================================================

			redirect_to @forum
		else

			render action: :new

		end
	end

	def not_joined_forum
	end

# used to enable the user of the current secession to like an idea
	def like
		@forum = Forum.find(params[:forum_id])
		@user = current_user
		@idea = Idea.find(params[:id])

	 	@likeidea = Likeidea.new(:user_id => @user.id , :idea_id => @idea.id)

		if @likeidea.save
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

		if @reportidea.save
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