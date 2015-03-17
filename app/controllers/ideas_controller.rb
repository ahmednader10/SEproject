class IdeasController < ApplicationController
	before_action :authenticate_user, only: :create

	#index method list all the idea titles related to a forum.
	def index
		@ideas = Idea.where(forum_id: params[:forum_id])
	end
	
	#show method showes the title and text of a chosen idea.
	def show
		 @idea = Idea.where(id: params[:id])
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
			redirect_to @forum
		else
			render action: :new
		end
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
		end
	end
end