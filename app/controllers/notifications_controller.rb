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
		@notification = Notification.new(notification_params)
		@notification.save
	end

	def destroy
		@notification.destroy
	end
end