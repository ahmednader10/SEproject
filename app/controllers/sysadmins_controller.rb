class SysadminsController < ApplicationController
  def new

  end

  def index
  end

  def show
    if current_user
      redirect_to logged_in_path and return
    end

    if params[:sysadmin][:username] == 'admin' and params[:sysadmin][:password] == 'password'
      session[:sysadmin] = true
      render 'show'
    else
      render 'index'
    end
  end

  def edit
    @user_tmp = User.find_by(email: params[:q])
    @users = User.all
    if @user_tmp
      #@user_tmp.destroy
      render 'edit'
    else
      render 'index'
    end
  end

  def forums
    @forums = Forum.all
  end

  def delete
  end 
end
