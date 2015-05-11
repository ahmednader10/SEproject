class ForgotpwController < ApplicationController
	def sendx
		user = User.find_by(email: forgotpw_sendx_params[:email])
		SendMail.forgot_password(user).deliver
	end

	def new
		
	end

protected

	def forgotpw_sendx_params
		params.require(:session).permit(:email)
	end
end
