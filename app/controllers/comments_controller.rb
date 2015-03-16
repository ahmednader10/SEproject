class CommentsController < ApplicationController
	def index
		@comments = Comment.where(ideaid: params[:idea_id])
	end

	def create
		@forum = Forum.find(params[:forum_id])
		@idea = Idea.find(params[:idea_id])
		@user = current_user
		if current_user = nil

		else
			@comment = Comment.new(comment_params)
			@comment.save
			redirect_to(@idea)
		end
	end

	protected
	def comment_params
		params.require(:comment).permit(:user_id, :forum_id, :idea_id, :text)
	end
end
