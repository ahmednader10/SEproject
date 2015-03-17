class CommentsController < ApplicationController
	before_action :authenticate_user, only: :create

	#index method list all the comments related to an idea.
	def index
		@comments = Comment.where(idea_id: params[:idea_id])
	end

   def new
   	@idea = idea.find(params[:idea_id])
		@comment = Comment.new
   end

   #enables the user to post a comment on an idea.
	def create
		@comment = @idea.comment.build(comment_params)
		@comment.user = current_user

		if 
			@comment.save
			redirect_to @idea

		else

			render action: :new

		end
	end

# used to allow the user to enter the information needed from him and nothing more inorder not to be able to change the model
protected
	def comment_params
		params.require(:comment).permit(:text)
	end
end

