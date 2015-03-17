class CommentsController < ApplicationController
	before_action :authenticate_user, only: :create

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
			redirect_to [@forum, @idea] 
		else
			render template: 'ideas/show'
		end
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

