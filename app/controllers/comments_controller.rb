class CommentsController < ApplicationController
	#index method list all the comments related to an idea.
	def index
		@comments = Comment.where(ideaid: params[:idea_id])
	end

   
   #enables the user to post a comment on an idea.
	def create
		@forum = Forum.find(params[:forum_id])
		@idea = Idea.find(params[:idea_id])
		@user = current_user
		if current_user == nil

		else
			@comment = Comment.new(comment_params)
			@comment.save
			redirect_to "ideas/show"
		end
	end

# used to allow the user to enter the information needed from him and nothing more inorder not to be able to change the model
protected
	def comment_params
		params.require(:comment).permit(:userid, :forumid, :ideaid, :text)
	end
end