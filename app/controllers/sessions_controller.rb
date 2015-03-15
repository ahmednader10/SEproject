class SessionsController < ApplicationController
  def new

  end


  def create 
   	
   	user = User.find_by(email: params[:session][:email].downcase)
  
  	
    if user && user.authenticate(params[:session][:password]) 

    #log_in method located in session_helper
    	log_in user
    #Redirects to an empty page
    #To be changed later
    	redirect_to(user)
    else

    	flash.now[:danger] = 'Invalid email/password combination'

  	render 'new'
    end
  end

  def logged_in

  end

  def destroy
  	log_out
    redirect_to root_url
  end

  def help
  end
  	
  def tempguest
  end

  def about
  end

  def contactus
  end

  def jobs
  end

  def forgot
  end

end
