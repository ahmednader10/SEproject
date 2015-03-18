class AdminsController < ApplicationController
  
  # index action just gets all the admins with their corresponding forums they are already
  # administrating. This is done by calling the new.html.erb view
  def index
    @admins = Admin.all
  end

  def show
  end

  # new action calls the new.html.erb view which contains the form for adding a new 
  # admin nad it also creates the forum with the id passed in the url to avoid the nil
  # exception and it creates a new admin.
  def new
    @forum = Forum.find(params[:forum_id])
    @admin = Admin.new
  end


  # create action takes the forum_id from the url parameteres and the user email (admin to be)
  # and adds an admin to the specified forum but after checking some conditions
  # First, checks if the email is written correctly, if not the user will be notified
  # Second, it checks if the user adding the new admin is already an admin to the current forum.
  def create 
    forum_id = params[:forum_id]
    user_email = params[:admin][:user]
    user = User.find_by(email: user_email)
    
    if User.exists?(:email => params[:admin][:user]) 
      if Admin.exists?(:forum_id => params[:forum_id], :user_id => current_user.id)
        user_id = user.id
        Admin.create!(forum_id: forum_id, user_id: user_id)
        redirect_to(:action => 'added_admin')
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
end
