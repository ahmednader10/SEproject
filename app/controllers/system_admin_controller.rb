class SystemAdminController < ApplicationController
  def new
  end

  def show
    if params[:username] == "admin" and params[:password]
      redirect_to 'show'
    else
      redirect_to 'index'
    end
  end

  def index
  end

  def edit
  end

  def delete
  end
end
