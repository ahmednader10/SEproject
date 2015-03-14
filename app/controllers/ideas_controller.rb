class IdeasController < ApplicationController
	def index
		@ideas = Idea.where(forum_id: params[:forum_id])
	end
end