class ActionsController < ApplicationController

	def index
		@actions = Action.all
	end

	def indexall
		@actions = Action.where(hidden: false)
	end

	def new
	end

	def create
		@action = Action.new(action_params)
		@action.save
	end

	def hide
		Action.find(params[:id]).update(hidden: true)
		redirect_to('/syslog')
	end

	def unhide
		Action.find(params[:id]).update(hidden: false)
		redirect_to('/syslogall')
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