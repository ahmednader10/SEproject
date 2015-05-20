class IdeasController < ApplicationController
	before_action :authenticate_user, only: [:create, :like, :report]
	before_action :check_forum_not_joined, only: :new

	#index method list all the idea titles related to a forum.
	def index
		@ideas = Idea.where(forum_id: params[:forum_id])
	end

	#show method shows the title and text of a chosen idea.
	def show
		@forum = Forum.find(params[:forum_id])
		@idea = Idea.find(params[:id])
		@comment = Comment.new
	end

	def new

		@forum = Forum.find(params[:forum_id])
		@idea = Idea.new

	end

	# a method that enables the forum admin to delete any idea written by any member in his forum or the user to delete his ideas
	def destroy
		@idea = Idea.find(params[:id])
		@forum = Forum.find(params[:forum_id])
		if current_user != nil
			if current_user != User.find(@idea.user_id)
				Action.create(info: current_user.username + ' has deleted an idea: (' + @idea.title + ') belonging to user: (' + User.find(@idea.user_id).username + ') located in forum: (' + @forum.title + ').', user_email: current_user.email)
				Notification.create(info: 'Your idea: (' + @idea.title + ') on forum:(' + @forum.title + ') has been deleted.', user_id: @idea.user_id)
			else
				Action.create(info: current_user.username + ' has deleted his idea: (' + @idea.title + ') located in forum: (' + @forum.title + ').', user_email: current_user.email)
			end
		else
			Action.create(info: 'A system admin has deleted an idea: (' + @idea.title + ') belonging to user: (' + User.find(@idea.user_id).username + ') located in forum: (' + @forum.title + ').', user_email: 'SystemAdmin')
			Notification.create(info: 'Your idea: (' + @idea.title + ') on forum:(' + @forum.title + ') has been deleted.', user_id: @idea.user_id)
		end
		@idea.destroy
		redirect_to forum_path(@forum)
	end


	#enables the user to create an idea by adding a title and text.
	def create

		# @idea = Idea.new(idea_params)
		# @idea.forum = @forum
		@idea = @forum.ideas.build(idea_params)
		@idea.user = current_user

		if @idea.save

			Action.create(info: current_user.username + ' has posted a new idea: (' + @idea.title + ') on forum: (' + Forum.find(@idea.forum_id).title + ').', user_email: current_user.email)

			# This block of code sends a notification to the admins of the forum being posted on
			# =================================================================
			admins = Admin.where(forum_id: @forum)
			admins.each do |admin|
				if @idea.user_id != admin.user_id
					Notification.create(info: (current_user.username + " has posted an idea (" + @idea.title + ") on a forum that you administrate (" + @forum.title + ")."), seen: false, user_id: admin.user_id, link: 'forums/' + @forum.id.to_s + 'ideas/' + @idea.id.to_s)
				end
			end
			# =================================================================

			redirect_to @forum
		else

			render action: :new

		end
	end

	#def not_joined_forum
	#end

	# used to enable the user of the current secession to like an idea
	def like
		@forum = Forum.find(params[:forum_id])
		@user = current_user
		@idea = Idea.find(params[:id])
		#@user= User.find_by(:id => @idea.user_id)

		@likeidea = Likeidea.new(:user_id => @user.id , :idea_id => @idea.id)
		@idea.increment!(:like_count, by = 1)

		if @likeidea.save
			Action.create(info: @user.username + ' has liked an idea: (' + @idea.title + ') belonging to user: (' + User.find(@idea.user_id).username + ') located in forum: (' + @forum.title + ').', user_email: @user.email)
			if @user.id != @idea.user_id
				<<<<<<< HEAD
				Notification.create(info: @user.username + ' has liked your idea: (' + @idea.title + ') on forum: (' + @forum.title + ').', user_id: @idea.user_id)
			end
			flash[:notice] = "Idea Liked!"
			=======
			Notification.create(info: @user.username + ' has liked your idea: (' + @idea.title + ') on forum: (' + @forum.title + ').', user_id: @idea.user_id, link: 'forums/' + @forum.id.to_s + 'ideas/' + @idea.id.to_s)
		end
		flash[:notice] = "Idea Liked!"
		>>>>>>> 3f4a2e470ff80b7a46d222dba14720f96cbc1e35
	end

	redirect_to forum_idea_path(@forum, @idea) # [@forum, @idea]
end

def unlike
	@forum = Forum.find(params[:forum_id])
	@user = current_user
	@idea = Idea.find(params[:id])
	if !Likeidea.where(user_id: @user.id, idea_id: @idea.id).empty?
		@likeidea = Likeidea.where(user_id: @user.id, idea_id: @idea.id)
		@likeidea.first.destroy
		flash[:notice] = "idea unliked!"
	end
	redirect_to forum_idea_path(@forum, @idea)
end
# allows user to report an idea
def report
	@forum = Forum.find(params[:forum_id])
	@user = current_user
	@idea = Idea.find(params[:id])

	@reportidea = Reportidea.new(:user_id => @user.id , :idea_id => @idea.id)

	if @idea.user_id == @user.id
		flash[:notice] = "Cannot report your own idea!"
	elsif @reportidea.save
		Action.create(info: @user.username + ' has reported an idea: (' + @idea.title + ') belonging to user: (' + User.find(@idea.user_id).username + ') located in forum: (' + @forum.title + ').', user_email: @user.email)
		Notification.create(info: 'Your idea: (' + @idea.title + ' on forum: (' + @forum.title + ') has been reported.', user_id: @idea.user_id)

	else
		flash[:notice] = "You've already reported this idea!"
	end

	redirect_to forum_idea_path(@forum, @idea) # [@forum, @idea]
end

def unreport
	@forum = Forum.find(params[:forum_id])
	@user = current_user
	@idea = Idea.find(params[:id])
	if !Reportidea.where(user_id: @user.id, idea_id: @idea).empty?
		@reportidea = Reportidea.where(user_id: @user.id, idea_id: @idea)
		@reportidea.first.destroy
		flash[:notice] = "idea unreported!"
	end
	redirect_to forum_idea_path(@forum, @idea)
end
# used to allow the user to enter the information needed from him and nothing more inorder not to be able to change the model
protected
def idea_params
	params.require(:idea).permit(:title, :text)
end
# used to check that there's a current user to be able to use the above actions
def authenticate_user
	@forum = Forum.find(params[:forum_id])
	if current_user == nil
		redirect_to @forum
	else

		if Membership.where(user_id: current_user.id , forum_id: @forum.id, accept: true).empty?

			render action: :not_joined_forum
		end
	end
end

def check_forum_not_joined
	@forum = Forum.find(params[:forum_id])
	if current_user != nil and Membership.where(user_id: current_user.id , forum_id: @forum.id, accept: true).empty?
		render action: :not_joined_forum

	end
end
end
