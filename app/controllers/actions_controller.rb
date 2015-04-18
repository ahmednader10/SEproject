class ActionsController < ApplicationController

	def index
		@actions = Action.all
	end

	def new
	end

	def create
		@action = Action.new(action_params)
	end

	def destroy
		Action.delete(params[:id])
		redirect_to('/syslog')
	end

protected

	def action_params
		params.require(:action).permit(:info, :user_id)
	end

end