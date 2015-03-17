class SearchController < ApplicationController
	
	def abdelghany
		@results = User.where(username: params[:q])
		@results += Forum.where(title: params[:q])
		@results += Idea.where(title: params[:q])
	end

end