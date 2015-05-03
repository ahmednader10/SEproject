
class SessionsController < ApplicationController

  # Checks if the user accessing the page is a current user
  # Redirects to Logged in
  def new
    session.delete(:sysadmin)
    if current_user
      redirect_to logged_in_path
    end
  end

  # Checks if the email and password match the database of users
  # redirects to logged in if matches
  # renders to new if doesnt match with an error on top
  def create 
   	
   	 user = User.find_by(email: params[:session][:email].downcase)
  	 blocked_user = Block.find_by(email: user.email)

    if user and user.authenticate(params[:session][:password]) and blocked_user
      render blocking_message_path and return
    end

    if user && user.authenticate(params[:session][:password]) 

    # log_in method located in session_helper
    	log_in user
      Action.create(info: current_user.username + ' has logged in.', user_id: current_user.id)

    # Redirects to an empty page
    # To be changed later
    	redirect_to user

    else

    	flash.now[:danger] = 'Invalid email/password combination!'

  	render 'new'
    end
  end

  # Method for Facebook and Twitter
  # Checks if user authorized 
  # if authorized redirects to logged_in_path
  # to be changed later
  def createF
        user = User.omniauth(env['omniauth.auth'])
        session[:user_id] = user.id
        Action.create(info: current_user.username + ' has logged in using facebook.', user_id: current_user.id)
        redirect_to user
  end


  # Destroys session
  # redirects to login
  # Login as a new user
  def destroy
    #Action.create(info: current_user.username + ' has logged out.', user_id: current_user.id)
    log_out
    redirect_to root_url
  end


  # After Login it redirects here
  def logged_in
  end

  # For any guides throughout the website
  # Include FAQs
  def help
  end
  	
  # If a client wants to view the webpage without signing up
  # should contain same website contents but with full restrictions
  def tempguest
  end

  # About the website and company 
  # Missions and visions
  def about
  end

 
  # Contains contact details for the company 
  # Implement later Online chat with customer service
  def contactus
  end

  # Contains a list of all available jobs 
  # Apply button for each job
  # Implement later a database for jobs handeled by adminstrators 
  def jobs
  end

  # If you forgot your password
  # Sends an email to user including their password
  # Answer personal questions and if matches you can change password onspot 
  def forgot
  end

end

