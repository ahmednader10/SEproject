module SessionsHelper

	#Logs user in with a temporary id that expires upon browser close.
	#Encrypted version of user id
	def log_in(user)
    	session[:user_id] = user.id
  	end

  	# Returns the current logged-in user (if any), nil otherwise.
 	 def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
 	 end

 	 # Returns true if the user is logged in, false otherwise.
  	def logged_in?
    	!current_user.nil?
  	end

  	# Logs out the current user.
 	 def log_out
    	session.delete(:user_id)
      @current_user = nil
    	
  	end

end
