class NotificationsController < ApplicationController
	def index
		@notifications = Notification.where(user_id: session[:user_id])
	end

	def show
		@notification = Notification.find(params[:id])
	end

	def new
	end

	def create
		@notification = Notification.create(notification_params)
	end

#	def edit
#	end
#
#	def update
#		@notification.update(notification_params)
#	end

	def destroy
		@notification.destroy
	end
end