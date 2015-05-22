class SearchController < ApplicationController
	
	def search
		# This part is for the normal search
		if params[:searchtype] == 'normal'
			if (current_user != nil || session[:sysadmin] == "true") && params[:q] != nil
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
			if (current_user != nil || session[:sysadmin] == "true") && params[:q] != nil
				Action.create(info: current_user.username + ' has made the following advanced search query : (' + params[:q] + ') for (type:' + params[:type] + ').', user_email: current_user.email)
				if params[:fromyear] == ''
					fromYear = Time.new(0).year
				else
					fromYear = params[:fromyear]
				end
				if params[:frommonth] == ''
					fromMonth = Time.new(0).month
				else
					fromMonth = params[:frommonth]
				end
				if params[:fromday] == ''
					fromDay = Time.new(0).day
				else
					fromDay = params[:fromday]
				end
				if params[:toyear] == ''
					toYear = Time.now.year
				else
					toYear = params[:toyear]
				end
				if params[:tomonth] == ''
					toMonth = Time.now.month
				else
					toMonth = params[:tomonth]
				end
				if params[:today] == ''
					toDay = Time.now.day.to_i + 1
				else
					toDay = params[:today]
				end
				from = Time.new(fromYear.to_i, fromMonth.to_i, fromDay.to_i)
				to = Time.new(toYear.to_i, toMonth.to_i, toDay.to_i, 23, 59, 59)
				if params[:type] == 'All'
					results1 = User.where("(UPPER(username) LIKE ('%' || UPPER(:q) || '%') OR UPPER(full_name) LIKE ('%' || UPPER(:q) || '%')) AND created_at BETWEEN :from AND :to", q: params[:q], from: from, to: to)
					results2 = Forum.where("(UPPER(title) LIKE ('%' || UPPER(:q) || '%')) AND created_at BETWEEN :from AND :to", q: params[:q], from: from, to: to)
					results3 = Idea.where("UPPER(title) LIKE ('%' || UPPER(:q) || '%') AND created_at BETWEEN :from AND :to", q: params[:q], from: from, to: to)
					if params[:sortby] == 'Newest'
						results1 = results1.order(created_at: :desc)
						results2 = results2.order(created_at: :desc)
						results3 = results3.order(created_at: :desc)
					elsif params[:sortby] == 'Oldest'
						results1 = results1.order(created_at: :asc)
						results2 = results2.order(created_at: :asc)
						results3 = results3.order(created_at: :asc)
					elsif params[:sortby] == 'Most Popular'
						results1 = results1.order(friend_count: :desc)
						results2 = results2.order(user_count: :desc)
						results3 = results3.order(like_count: :desc)
					end
					@results = results1 + results2 + results3
				elsif params[:type] == 'Users'
					@results = User.where("(UPPER(username) LIKE ('%' || UPPER(:q) || '%') OR UPPER(full_name) LIKE ('%' || UPPER(:q) || '%')) AND created_at BETWEEN :from AND :to", q: params[:q], from: from, to: to)
					if params[:sortby] == 'Newest'
						@results = @results.order(created_at: :desc)
					elsif params[:sortby] == 'Oldest'
						@results = @results.order(created_at: :asc)
					elsif params[:sortby] == 'Most Popular'
						@results = @results.order(friend_count: :desc)
					end
				elsif params[:type] == 'Forums'
					@results = Forum.where("(UPPER(title) LIKE ('%' || UPPER(:q) || '%')) AND created_at BETWEEN :from AND :to", q: params[:q], from: from, to: to)
					if params[:sortby] == 'Newest'
						@results = @results.order(created_at: :desc)
					elsif params[:sortby] == 'Oldest'
						@results = @results.order(created_at: :asc)
					elsif params[:sortby] == 'Most Popular'
						@results = @results.order(user_count: :desc)
					end
				elsif params[:type] == 'Ideas'
					@results = Idea.where("UPPER(title) LIKE ('%' || UPPER(:q) || '%') AND created_at BETWEEN :from AND :to", q: params[:q], from: from, to: to)
					if params[:sortby] == 'Newest'
						@results = @results.order(created_at: :desc)
					elsif params[:sortby] == 'Oldest'
						@results = @results.order(created_at: :asc)
					elsif params[:sortby] == 'Most Popular'
						@results = @results.order(like_count: :desc)
					end
				end
			end
		end
	end

	# Points to do:
	# 	blocked users shouldn't show
	# 	relevance

end