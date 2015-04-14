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
  end

  def delete
  end

  
end
