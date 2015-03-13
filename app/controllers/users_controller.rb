class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    indentation_check = @user.username.match(/\s/) ? true : false
      if indentation_check == false and @user.save 
      #  session[:user_id] = @user.id
        redirect_to(:action => 'index')
      
      else
        render 'new'
      end
  end

  def edit
  end

  def delete
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :gender, :full_name, :password_question, :answer_for_password_question)
  end
end
