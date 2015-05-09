class SearchController < ApplicationController
	
	def search
		if current_user != nil && params[:q] != nil
			Action.create(info: current_user.username + ' has made the following search query : (' + params[:q] + ') for (type:' + params[:type] + ').', user_email: current_user.email)		
			if params[:type] == 'All'
				@results = User.where("UPPER(username) LIKE ('%' || UPPER(:q) || '%') OR UPPER(full_name) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
				@results += Forum.where("UPPER(title) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
				@results += Idea.where("UPPER(title) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
			elsif params[:type] == 'Users'
				@results = User.where("UPPER(username) LIKE ('%' || UPPER(:q) || '%') OR UPPER(full_name) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
			elsif params[:type] == 'Forums'
				@results = Forum.where("UPPER(title) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
			elsif params[:type] == 'Ideas'
				@results = Idea.where("UPPER(title) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
			end
		end
	end

	def advanced_search
	end

end