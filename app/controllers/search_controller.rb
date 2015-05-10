class SearchController < ApplicationController
	
	def search
		# This part is for the normal search
		if params[:searchtype] == 'normal'
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
		# This part is for the advanced search
		elsif params[:searchtype] == 'advanced'
			if current_user != nil && params[:q] != nil
				Action.create(info: current_user.username + ' has made the following advanced search query : (' + params[:q] + ') for (type:' + params[:type] + ').', user_email: current_user.email)		
				if params[:type] == 'All'
					results1 = User.where("UPPER(username) LIKE ('%' || UPPER(:q) || '%') OR UPPER(full_name) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
					if params[:sortby] == 'Newest'
						results1 = results1.order(created_at: :desc)
					elsif params[:sortby] == 'Oldest'
						results1 = results1.order(created_at: :asc)
					elsif params[:sortby] == 'Most Popular'
						results1 = results1.sort_by{|result| (Friendship.where(user_id: result.id).count + Friendship.where(friend_id: result.id).count)}
					end
					results2 = Forum.where("UPPER(title) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
					if params[:sortby] == 'Newest'
						results2 = results2.order(created_at: :desc)
					elsif params[:sortby] == 'Oldest'
						results2 = results2.order(created_at: :asc)
					elsif params[:sortby] == 'Most Popular'
						results2 = results2.sort_by{|result| Membership.where(forum_id: result2.id).count}
					end
					results3 = Idea.where("UPPER(title) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
					if params[:sortby] == 'Newest'
						results3 = results3.order(created_at: :desc)
					elsif params[:sortby] == 'Oldest'
						results3 = results3.order(created_at: :asc)
					elsif params[:sortby] == 'Most Popular'
						results3 = results3.sort_by{|result| Likeidea.where(idea_id: result2.id).count}
					end
					@results = results1 + results2 + results3
				elsif params[:type] == 'Users'
					@results = User.where("UPPER(username) LIKE ('%' || UPPER(:q) || '%') OR UPPER(full_name) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
					if params[:sortby] == 'Newest'
						@results = @results.order(created_at: :desc)
					elsif params[:sortby] == 'Oldest'
						@results = @results.order(created_at: :asc)
					elsif params[:sortby] == 'Most Popular'
						@results = @results.sort_by{|result| (Friendship.where(user_id: result.id).count + Friendship.where(friend_id: result.id).count)}
					end
				elsif params[:type] == 'Forums'
					@results = Forum.where("UPPER(title) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
					if params[:sortby] == 'Newest'
						@results = @results.order(created_at: :desc)
					elsif params[:sortby] == 'Oldest'
						@results = @results.order(created_at: :asc)
					elsif params[:sortby] == 'Most Popular'
						@results = @results.sort_by{|result| Membership.where(forum_id: result2.id).count}
					end
				elsif params[:type] == 'Ideas'
					@results = Idea.where("UPPER(title) LIKE ('%' || UPPER(:q) || '%')", q: params[:q])
					if params[:sortby] == 'Newest'
						@results = @results.order(created_at: :desc)
					elsif params[:sortby] == 'Oldest'
						@results = @results.order(created_at: :asc)
					elsif params[:sortby] == 'Most Popular'
						@results = @results.sort_by{|result| Likeidea.where(idea_id: result2.id).count}
					end
				end
			end
		end
	end

	# Points to do:
	# 	blocked users shouldn't show
	# 	relevance

	def advanced_search
	end

end