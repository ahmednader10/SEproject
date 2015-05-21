class ForumsController < ApplicationController

	# Views all forums showing their title and description.
	def index
		@forums = Forum.all
		@user = current_user

		if @user == nil
			redirect_to root_url
		end
	end

	# Views a specific forum. Users can post ideas here.
	def show

		#check if memeber then enable editing

		sleep 1
		@forum = Forum.find(params[:id])

		@ideas = []
		if !Idea.where(forum_id: params[:id]).empty?
			@ideas.concat(Idea.where(forum_id: params[:id]).order(created_at: :desc))
		end
		@comment = Comment.new
		@idea = Idea.new
		@admin = Admin.new
	end

	# Renders the page for creating a forum.
	def new
		@forum = Forum.new
	end

	# Renders the page for editing a forum.
	def edit
		@forum = Forum.find(params[:id])
	end

	# Creates a forum and saves it in the database. Also here is where making a user an admin is handled.
	def create
		@forum = Forum.new(forum_params)
		@user = current_user

		if @user == nil

			#flash[:notice] = 'You should login first'

			redirect_to root_url
		else
			admin = @forum.admins.build(user: @user)

			if @forum.category == "- Select a category -"
				@forum.category = nil
			end

			membership = @forum.memberships.build(user: @user)
			if @forum.save && admin.save

				membership.accept = true
				membership.save
				@forum.increment!(:user_count, by = 1)

				Action.create(info: (@user.username + ' has created a new forum: (' + @forum.title + ').'), user_email: @user.email)

				redirect_to(forums_path)
			else
				render 'new'
			end
		end
	end

	# Updates the record of the forum in the database with the new data, and makes sure this is only done by the admin
	# of the forum.
	def update
		@forum = Forum.find(params[:id])
		@user = current_user

		if params[:forum][:category] == "- Select a category -"
			#@forum.category = nil
			params[:forum][:category] = nil
		end

		if session[:sysadmin] && @forum.update(forum_params)
			redirect_to(forums_sysadmins_path) and return
		end
		if @user == nil
			flash[:notice] = 'You should login first'

			# flash[:notice] = 'You should login first'
			redirect_to root_url
		else
			admin = Admin.where({ forum_id: @forum.id, user_id: @user.id })
			if !admin.empty? && @forum.update(forum_params)

				Action.create(info: (@user.username + ' has updated the forum: (' + @forum.title + ').'), user_email: @user.email)

				admins = Admin.where(forum_id: @forum_id)
				admins.each do |a|
					Notification.create(info: @user.username + ' has updated your forum: (' + @forum.title + ').', user_id: a.user_id, link: '/forums/' + @forum.id.to_s)
				end

				redirect_to(forums_path)
			else
				render 'edit'
			end
		end
	end

	# Deletes a forum, and makes sure that a forum is only deleted by its admin.
	def destroy
		@forum = Forum.find(params[:id])
		@user = current_user
		if session[:sysadmin]
			Action.create(info: 'A system administrator has deleted the forum: (' + @forum.title + ').', user_email: 'SystemAdmin')

			admins = Admin.where(forum_id: @forum.id)
			admins.each do |a|
				Notification.create(info: 'A system administrator has deleted your forum: (' + @forum.title + ').', user_id: a.user_id)
			end

			@forum.destroy
			redirect_to forums_sysadmins_path and return
		end
		if @user == nil
			redirect_to root_url
		else
			admin = Admin.where({ forum_id: @forum.id, user_id: @user.id })
			if !admin.empty?
				# confirm then delete
				Action.create(info: @user.username + ' has deleted the forum: (' + @forum.title + ').', user_email: @user.email)

				admins = Admin.where(forum_id: @forum.id)
				admins.each do |a|
					if a.user_id != @user.id
						Notification.create(info: @user.username + ' has deleted your forum: (' + @forum.title + ').', user_id: a.user_id)
					end
				end

				@forum.destroy
				# admin.destroy
				redirect_to forums_path
			else
				# refuse and redirect
				redirect_to forums_path
			end
		end
	end

	# A temporary page that shows up after creating a forum. Only notifies the user that the forum has been created.
	def created
		@forum = Forum.find(params[:id])
	end

	#method that enables the forum admin to remove any member from his forum and delete
	# his record from membership table
	def remove_member
		user = params[:user]
		forum = params[:forum]
		@membership1 = Membership.where(user_id: user , forum_id: forum)

		@membership1.first.destroy
		Action.create(info: current_user.username + ' has removed a member: (' + user.username + ') from the forum: (' + forum.title + ').', user_email: current_user.email)
		Notification.create(info: 'You have been removed from forum: (' + forum.title + ').', user_id: user.id)
		# redirect_to 'list_members'
		redirect_to list_members_path(id: forum)
	end

	#A method that returns a list of all the members in a certain forum
	def list_members
		# @forum = Forum.find(params[:id])
		# @users = @forum.accepted_users

		@users = []
		@forum = Forum.find(params[:id])
		forums_ids = Membership.where(forum_id: @forum.id , accept: true)
		if !forums_ids.empty?
			forums_ids.each do |r|
				if !User.where(id: r.user_id).empty?
					@users.concat(User.where(id: r.user_id))
				end
			end
		end
	end

	def leave_forum
     	@user = current_user
		@forum = Forum.find(params[:id])
		@membership1 = Membership.where(user_id: @user , forum_id: @forum)
		@membership1.first.destroy
    	redirect_to :action => "show"
  	end

  	def cancel_join_request
     	@user = current_user
		@forum = Forum.find(params[:id])
		@membership1 = Membership.where(user_id: @user , forum_id: @forum , accept: nil)
		@membership1.first.destroy
    	redirect_to :action => "show"
  	end

	# join action enables logged in user to join public forums through clicking on the button
	# "join Forum" and also enables logged in user to send request to join private forums and it checks
	# if the user has already joined the forum before
	def join_forum
		@user = current_user
		@forum = Forum.find(params[:id])
		if @user == nil
			flash[:notice] = 'You should login first to be able to join forum'
			redirect_to root_url
		else
			@membership = @forum.memberships.build(user: @user)
			if @forum.privacy == '1'
				Action.create(info: @user.username + ' has joined the forum: (' + @forum.title + ').', user_email: @user.email)
				@forum.increment!(:user_count, by = 1)
			else
				Action.create(info: @user.username + ' has requested to join the forum: (' + @forum.title + ').', user_email: @user.email)
			end
			@membership.accept = true if @forum.privacy == '1'
			if  @membership.save and @membership.accept == true

				flash[:success] = 'Successfully joined forum'
				redirect_to :action => "show"
				Notification.create(info: 'Your request to join forum: (' + @forum.title + ') has been accepted and you have successfully joined.', user_id: @user.id, link: '/forums/' + @forum.id.to_s)
			elsif @membership.accept == true  and !@membership.save
				#need to check in the database first if this record already exists
				flash[:member] = 'already member of this forum'
				redirect_to :action => "show"

			elsif @membership.accept == nil and !@membership.save
				flash[:requestsent] = 'already sent request to join this forum'
				redirect_to :action => "show"
			elsif @membership.accept == nil
				flash[:pending] = 'Pending request'
				redirect_to :action => "show"
			end
		end
		#send notification joined successfully
	end

	# Strong parameters
	private
	def forum_params
		params.require(:forum).permit(:title, :description, :privacy, :category)
	end

end
