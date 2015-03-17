class AdminsController < ApplicationController
  def index
    @admins = Admin.all
  end

  def show
  end

  def new
    @forum = Forum.find(params[:forum_id])
    @admin = Admin.new
  end

  def create 
    forum_id = params[:forum_id]
    user_email = params[:admin][:user]
    user = User.find_by(email: user_email)
    
    if User.exists?(:email => params[:admin][:user]) 
      if Admin.exists?(:forum_id => params[:forum_id], :user_id => current_user.id)
        user_id = user.id
        Admin.create!(forum_id: forum_id, user_id: user_id)
        redirect_to(:action => 'index')
      else
         redirect_to(action: 'unauthorized_action') 
      end
    else
        redirect_to(action: 'wrong_email')
    end
  end

  def edit
  end

  def delete
  end

  private
  def unauthorized_action
  end

  def wrong_email
  end
end
