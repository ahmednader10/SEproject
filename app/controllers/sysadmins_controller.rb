class SysadminsController < ApplicationController
  def new

  end

  def index
  end

  def show
    if params[:sysadmin][:username] == 'admin' and params[:sysadmin][:password] == 'password'
      render 'show'
    else
      render 'index'
    end
  end

  def edit
    @user_tmp = User.find_by(email: params[:q])
    @users = User.all
    if @user_tmp
      @user_tmp.destroy
      render 'edit'
    else
      render 'index'
    end
  end

  def delete
  end 
end
