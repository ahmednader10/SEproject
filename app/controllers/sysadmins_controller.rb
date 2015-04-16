class SysadminsController < ApplicationController
  def new

  end

  def index
  end

  def show
    if current_user
      redirect_to logged_in_path and return
    end

    if session[:sysadmin] or (params[:sysadmin][:username] == 'admin' and params[:sysadmin][:password] == 'password')
      session[:sysadmin] = true
      render 'show'
    else
      render 'index'     #should be changed
    end
  end

  def edit
    @user_tmp = User.find_by(email: params[:q])
    @users = User.all
    if @user_tmp
      #@user_tmp.destroy                #has to be solved
      render 'edit'
    else
      render 'index'
    end
  end

  def userBlocked
    @user_to_be_blocked = User.find_by(email: params[:block_user])
    if !@user_to_be_blocked
      render 'show'
    else
      block = Block.new(email: @user_to_be_blocked.email)
      if block.save
        render blocked_path
      else
        render 'show'
      end
    end
    #block = Block.new(email: @user_to_be_blocked.email)
    #if @user_to_be_blocked and block.save and block.email != nil
    #  redirect_to blocked_path
    #else
    #  redirect_to root_path
    #end

  end

  def forums
    @forums = Forum.all
  end

  def delete
  end 
end
