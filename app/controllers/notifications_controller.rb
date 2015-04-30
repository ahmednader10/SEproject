class NotificationsController < ApplicationController
	
	#'index' lists all notifications for the currently online user.
	def index
		if current_user != nil
			@notifications = Notification.where(user_id: current_user.id)
		end
	end

	#'create' is for creating new notifications and saving them into the database.
	def create
		@notification = Notification.new(notification_params)
		if @notification.save
			Action.create(info: current_user.username + ' was sent this notification: (' + @notification.info + ').', user_email: current_user.email)
		end
	end

	# 'update' is used for updating the seen field to true when it is loaded into the notifications page
	def update
		if @notification.update(notification_params)
			Action.create(info: current_user.username + ' has seen this notification: (' + @notification.info + ').', user_email: current_user.email)
		end
	end

	#'destroy' is for deleting notifications from the database
	def destroy
		@notification = Notification.find(params[:id])
		if current_user != nil
			Action.create(info: current_user.username + ' has deleted this notification: (' + @notification.info + ') belonging to ' + User.find(@notification.user_id).username + '.', user_email: current_user.email)
		else
			Action.create(info: 'A system has deleted this notification: (' + @notification.info + ') belonging to ' + User.find(@notification.user_id).username + '.', user_email: 'SystemAdmin')
		end
		@notification.destroy
		redirect_to('/notifications')
	end

protected

	#'notification_params' is a helper method called in create to enforce strong params.
	def notification_params
		params.require(:notification).permit(:info, :seen, :user_id)
	end

end