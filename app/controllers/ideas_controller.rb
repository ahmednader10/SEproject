class IdeasController < ApplicationController
	#index method list all the idea titles related to a forum.
	def index
		@ideas = Idea.where(forum_id: params[:forum_id])
	end
	
	#show method showes the title and text of a chosen idea.
	def show
		 @idea = Idea.where(id: params[:id])
	end

   # retrieves the new.html.rb that contains a layout 
   #that enables the user to create and idea by adding a title and text.
	def new
		@idea = Idea.new(user_id: current_user.id, forum_id: params[:id])
	end

	def create
		@idea = Idea.new(idea_params)
		@forum = Forum.find(params[:id])
		@user = current_user
		if current_user == nil

		else
		@user = current_user
		@idea = @forum.ideas.build(user: @user)
		@idea.save
		redirect_to @forum
		end
	end

# used to allow the user to enter the information needed from him and nothing more inorder not to be able to change the model
protected
	def idea_params
		params.require(:idea).permit(:title, :text)
	end
end