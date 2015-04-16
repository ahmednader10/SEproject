
class SessionsController < ApplicationController
  def new
    session.delete(:sysadmin)
    if current_user
      redirect_to logged_in_path
    end
  end


  def create 
   	
   	 user = User.find_by(email: params[:session][:email].downcase)
  	blocked_user = Block.find_by(email: user.email)

    if user and user.authenticate(params[:session][:password]) and blocked_user
      render blocking_message_path and return
    end

    if user && user.authenticate(params[:session][:password]) 

    #log_in method located in session_helper
    	log_in user

    #Redirects to an empty page
    #To be changed later
    	redirect_to user
    else

    	flash.now[:danger] = 'Invalid email/password combination!'

  	render 'new'
    end
  end

  #Method for Facebook 
  def createF
        user = User.omniauth(env['omniauth.auth'])
        session[:user_id] = user.id
        redirect_to user
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def logged_in
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

