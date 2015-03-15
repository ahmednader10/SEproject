class NotificationsController < ApplicationController
	
	#'index' lists all notifications for the corresponding user
	#until now it lists notifications for the user corresponding to the user_id from the url, because sessions haven't been handled yet
	#it should later only allow listing for notifications of the user of the current session
	def index
		if current_user != nil
			@notifications = Notification.where(user_id: current_user.id)
		end
	end

	def new
	end

	#'create' is for creating new notifications and saving them into the database
	def create
		@notification = Notification.new(notification_params)
		@notification.save
	end

	#'destroy' is for deleting notifications from the database
	def destroy
		@notification.destroy
	end

protected

	#'notification_params' is a helper method called in create to enforce strong params
	def notification_params
		params.require(:notification).permit(:info, :seen, :user_id)
	end
end