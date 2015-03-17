<<<<<<< HEAD
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

  # accept_join_request method gets parameters of the user and the forum from the url and 
  # updates the record in the membership table for the user to be a member in this forum

  def accept_join_request
    user = params[:user]
    forum = params[:forum]
    @membership1 = Membership.where(user_id: user , forum_id: forum)
   
    @membership1.first.accept = true
    @membership1.first.save
    redirect_to(:action => "admin_join_forums_requests")
  end

  # reject_join_request method gets parameters of the user and the forum from the url and 
  # updates the record in the membership table by removing it 


  def reject_join_request
     user = params[:user]
    forum = params[:forum]
    @membership1 = Membership.where(user_id: user , forum_id: forum)
   
    @membership1.first.destroy
    redirect_to(:action => "admin_join_forums_requests")

  end

  # admin_join_forums_requests shows all the requests from users to join the forums 
  # of the logged in admin

  def admin_join_forums_requests
    @user = current_user
    @requests_forums = []
    @requests_users = []
    # check if user is admin
    admin_forums = Admin.where(user_id: @user.id)
    if admin_forums != nil
      admin_forums.each do |admin_forum|
        requests_ids = Membership.where(forum_id: admin_forum.forum_id , accept: nil)
        if !requests_ids.empty?
          requests_ids.each do |r|
            @requests_forums.concat(Forum.where(id: r.forum_id))
            @requests_users.concat(User.where(id: r.user_id))
       #Forum.@forums.each do |forum|
       # if forum.id == joined_forum.id
       #   @requests << forum.title
       # end
     # end

    end
    end
   # @forum = Forum.find(19)
   end
   end 
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

=======
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

  # accept_join_request method gets parameters of the user and the forum from the url and 
  # updates the record in the membership table for the user to be a member in this forum

  def accept_join_request
    user = params[:user]
    forum = params[:forum]
    @membership1 = Membership.where(user_id: user , forum_id: forum)
   
    @membership1.first.accept = true
    @membership1.first.save
    redirect_to(:action => "admin_join_forums_requests")
  end

  # reject_join_request method gets parameters of the user and the forum from the url and 
  # updates the record in the membership table by removing it 


  def reject_join_request
     user = params[:user]
    forum = params[:forum]
    @membership1 = Membership.where(user_id: user , forum_id: forum)
   
    @membership1.first.destroy
    redirect_to(:action => "admin_join_forums_requests")

  end

  # admin_join_forums_requests shows all the requests from users to join the forums 
  # of the logged in admin

  def admin_join_forums_requests
    @user = current_user
    @requests_forums = []
    @requests_users = []
    
    admin_forums = Admin.where(user_id: @user.id)
    if admin_forums != nil
      admin_forums.each do |admin_forum|
        requests_ids = Membership.where(forum_id: admin_forum.forum_id , accept: nil)
        if !requests_ids.empty?
          requests_ids.each do |r|
            @requests_forums.concat(Forum.where(id: r.forum_id))
            @requests_users.concat(User.where(id: r.user_id))
       

    end
    end
   
   end
   end 
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

>>>>>>> 98d4e719fe4fa2912525c362cce2923a93918421
