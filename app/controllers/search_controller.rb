class SearchController < ApplicationController
	
	def search
		if current_user != nil && params[:q] != nil
			Action.create(info: current_user.username + ' has made the following search query : (' + params[:q] + ').', user_email: current_user.email)		
			@results = User.where("UPPER(username) = UPPER(:q) or UPPER(full_name) = UPPER(:q)", q: params[:q])
			@results += Forum.where("UPPER(title) = UPPER(:q)", q: params[:q])
			@results += Idea.where("UPPER(title) = UPPER(:q)", q: params[:q])
		end
	end

end