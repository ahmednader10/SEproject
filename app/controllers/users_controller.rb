class UsersController < ApplicationController
  
  # index action gets all the registered users in the database and calls the 
  # index.html.erb view ro view this data.
  def index
    @users = User.all
  end

  # new action calls the new.html.erb view which contains the sign up form in order for
  # a user to register, it also creates a user instance without saving it in the database.
  def new
    @user = User.new
  end

  # create action checks if the username has no spaces then it checks the validations specified
  # in the model file (user.rb) and if all of these checks are true, a user is then registered and
  # saved in the database and a re-direction to index.html.erb occurs, otherwise the view new.html.erb 
  # is rendered again. Also, the email is downcased to make the search in the future easier.
  def create
    @user = User.new(user_params)
    @user.email.downcase!
    indentation_check = @user.username.match(/\s/) ? true : false

    
      if indentation_check == true
        flash[:notice] = "Username can't have spaces in it."
        redirect_to(:action => 'indentation_error_message')
      else 
        if @user.save
          redirect_to(:action => 'index')
        else
          render 'new' 
        end

      end
  end

  def edit
  end

  def delete
  end
  
  #user show is the action taken when you try and view someone's profile, it checks whether or not this profile belongs to the
  #current user and if it does redirects to the profile action which renders the profile view


   def show
      @user = User.find(params[:id])
      if @user == current_user
        redirect_to(:action => 'profile')
      end
    end



  #opens the profile view of the user
    def profile
      @current_user = current_user
    end
  # user_params action requires the model user and whenever we want to retrieve the user's parameteres
  # we can do so using this action. Also it prevents a user from hacking into the app and changing the
  # model.
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :gender, :full_name, :password_question, :answer_for_password_question)
  end
end
