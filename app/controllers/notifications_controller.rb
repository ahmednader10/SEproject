class NotificationsController < ApplicationController
	
	#'index' lists all notifications for the currently online user.
	def index
		if current_user != nil
			@notifications = Notification.where(user_id: current_user.id)
		end
	end

	def new
	end

	#'create' is for creating new notifications and saving them into the database.
	def create
		@notification = Notification.new(notification_params)
		@notification.save
	end

	#'destroy' is for deleting notifications from the database, after they have been rendered not anymore usable.
	def destroy
		@notification.destroy
	end

protected

	#'notification_params' is a helper method called in create to enforce strong params.
	def notification_params
		params.require(:notification).permit(:info, :seen, :user_id)
	end
end