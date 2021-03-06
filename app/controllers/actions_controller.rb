class ActionsController < ApplicationController

	def indexall
		@actions = Action.all
	end

	def index
		@actions = Action.where(hidden: false)
	end

	def create
		@action = Action.new(action_params)
		@action.save
	end

	def hide
		Action.find(params[:id]).update(hidden: true)
		redirect_to :back
	end

	def unhide
		Action.find(params[:id]).update(hidden: false)
		redirect_to :back
	end

	def hideall
		Action.all.each do |action|
			action.update(hidden: true)
		end
		redirect_to :back
	end

	def unhideall
		Action.all.each do |action|
			action.update(hidden: false)
		end
		redirect_to :back
	end

	def destroy
		Action.delete(params[:id])
		redirect_to :back
	end

protected

	def action_params
		params.require(:action).permit(:info, :user_email)
	end

end