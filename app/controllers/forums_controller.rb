class ForumsController < ApplicationController
	def index
		@forums = Forum.all
	end

	def show
		@forum = Forum.find(params[:id])
	end

	def new
		@forum = Forum.new
	end

	def create
  		@forum = Forum.new(forum_params)
 
  		if @forum.save
  			redirect_to(created_path(@forum))
  		else
  			render 'new'
  		end
	end

	def created
		@forum = Forum.find(params[:id])
	end
 
private
  def forum_params
    params.require(:forum).permit(:title, :description, :privacy)
  end
end
