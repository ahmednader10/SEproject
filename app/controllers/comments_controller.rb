class CommentsController < ApplicationController
	before_action :authenticate_user, only: [:create, :reportcomment]

	#index method list all the comments related to an idea.
	def index
		@comments = Comment.where(idea_id: params[:idea_id])
	end

	# creates a new comment
   def new
   	@idea = idea.find(params[:id])
		@comment = Comment.new
   end

   #enables the user to post a comment on an idea.
	def create
		@forum = Forum.find(params[:forum_id])
		@comment = @idea.comments.build(comment_params)
		@comment.user = current_user

		if @comment.save
			
			# This line of code sends a notification to the owner of the idea being commented on
			Notification.create(info: (current_user.username + ' has commented on your idea (' + @idea.title + ').'), seen: false, user_id: @idea.user_id)

			Action.create(info: (current_user.username + 'has commented on idea: (' + @idea.title + ') in the (' Forum.find(@idea.forum_id).title ') forum.'), user_id: current_user.id)
			
			redirect_to [@forum, @idea] 
		else
			render template: 'ideas/show'
		end
	end

	def reportcomment
	@forum = Forum.find(params[:forum_id])
		@user = current_user
		@idea = Idea.find(params[:idea_id])
		@comment = Comment.find(params[:id])

	 	@reportcomment = Reportcomment.new(:user_id => @user.id , :comment_id => @comment.id)

		if @reportcomment.save
	   		flash[:notice] = "Comment has been reported!"
	   		Action.create(info: (User.find(@user.id).username + ' has reported a comment (' + Comment.find(@comment.id).text + ') present in idea: (' + Idea.find(@comment.idea_id).title + ') in forum: (' + Forum.find(Idea.find(@comment.idea_id).id).title + ')', user_id: @user.id)
		else
			flash[:notice] = "You've already reported this comment!"
		end

      	redirect_to forum_idea_path(@forum, @idea) # [@forum, @idea]
	end

# used to allow the user to enter the comment and nothing more inorder not to be able to change the comment's model
protected
	def comment_params
		params.require(:comment).permit(:text)
	end

# check for user secession (makes sure a user is logged in)
	def authenticate_user
		@idea = Idea.find(params[:idea_id])

		if current_user == nil
			redirect_to login_path
		end

	end
end

