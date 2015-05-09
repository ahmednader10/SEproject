class SearchController < ApplicationController
	
	def search
		if current_user != nil && params[:q] != nil
			Action.create(info: current_user.username + ' has made the following search query : (' + params[:q] + ') for (type:' + params[:type] + ').', user_email: current_user.email)		
			if params[:type] == 'All'
				@results = User.where("UPPER(username) = UPPER(:q) or UPPER(full_name) = UPPER(:q)", q: params[:q])
				@results += Forum.where("UPPER(title) = UPPER(:q)", q: params[:q])
				@results += Idea.where("UPPER(title) = UPPER(:q)", q: params[:q])
			elsif params[:type] == 'Users'
				results = User.where("UPPER(username) = UPPER(:q) or UPPER(full_name) = UPPER(:q)", q: params[:q])
			elsif params[:type] == 'Forums'
				@results = Forum.where("UPPER(title) = UPPER(:q)", q: params[:q])
			elsif params[:type] == 'Ideas'
				@results = Idea.where("UPPER(title) = UPPER(:q)", q: params[:q])
			end
		end
	end

end