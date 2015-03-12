class NotificationsController < ApplicationController
	def index
		@notifications = Notification.where(user_id: params[:user_id])
	end

	def new
	end

	def create
		@notification = Notification.new(notification_params)
		@notification.save
	end

	def destroy
		@notification.destroy
	end

protected

	def notification_params
		params.require(:notification).permit(:info, :seen, :user_id)
	end
end