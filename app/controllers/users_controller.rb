
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
    @user.username.downcase!
    indentation_check = @user.username.match(/\s/) ? true : false
      if indentation_check == true
        flash[:notice] = "Username can't have spaces in it."
        #redirect_to(:action => 'indentation_error_message')
        render 'new'
      else 
        if @user.save
          @user.image =nil
          Action.create(info: 'A new user: (' + @user.username + ') has signed up.', user_email: @user.email)
          session[:signin] = "You have successfully signed up! You can now login."
          #@current_user_new = User.where(email: params[:email])
          #current_user = @user
          #redirect_to user_path(current_user.id)
          redirect_to root_path
          #redirect_to profile_path(@current_user_new)
        else
          render 'new' 
        end
      end
  end

  def edit
    user = User.find(params[:id])
  end

  def delete
  end

#this method is used to update the user attributes it checks all validations that are required for user 
#if all the checks are valid then the information gets updated and are saved in the data base

  def update 
    @user = current_user
    if @user == nil

      flash[:notice] = 'You should login first'

      # flash[:notice] = 'You should login first'
        redirect_to root_url
      else
      if @user.update_attributes(user_params)
          Action.create(info: @user.username + ' has updated his personal information.', user_email: @user.email)
          redirect_to(user_path)
      else
        render 'edit'
      end
    end
  end

  # opens the profile of other users, by retrieving their id and getting their info 
  def show
     @user = User.find(params[:id])
      if @user == current_user
        redirect_to(:action => 'profile')
      end
   end


    #opens the profile view of the user
 def profile
   @user = current_user
 end

     

     def deleteImage
      @user =current_user
      @user.image.destroy
        if @user.save
          redirect_to(user_path)
        end 
      end 


  # accept_join_request method gets parameters of the user and the forum from the url and 
  # updates the record in the membership table for the user to be a member in this forum
  def accept_join_request
    user = params[:user]
    @user = User.find(user)
    forum = params[:forum]
    @forum = Forum.find(forum)
    @membership1 = Membership.where(user_id: user , forum_id: forum)
    @membership1.first.accept = true
    @membership1.first.save
    Action.create(info: current_user.username + ' has accepted ' + @user.username + "'s join request to forum: (" + @forum.title + ').', user_email: current_user.email)
    redirect_to(:action => "admin_join_forums_requests")
  end

  # reject_join_request method gets parameters of the user and the forum from the url and 
  # updates the record in the membership table by removing it 
  def reject_join_request
    user = params[:user]
    @user = User.find(user)
    forum = params[:forum]
    @forum = Forum.find(forum)
    @membership1 = Membership.where(user_id: user , forum_id: forum)
    Action.create(info: current_user.id + ' has rejected ' + @user.username + "'s join request to forum: (" + @forum.title + ').', user_email: current_user.email)
    Notification.create(info: 'Your request to join forum: (' + @forum.title + ' has been rejected.', user_id: user.id)
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
          end
        end
      end
    end 
  end
  
  
  #user show is the action taken when you try and view someone's profile, it checks whether or not this profile belongs to the
  #current user and if it does redirects to the profile action which renders the profile view




#this method blocks a user from the system so he can't add him

  def block_user
  @user = current_user
  @friend = User.find( params[:user_id])

  @blocked= Blocker.new(:blocker_id => @user.id , :blocked_id => @friend.id, :blocker => @user.username, :blocked => @friend.username)

  Action.create(info: @user.username + ' has blocked ' + @friend.username + '.', user_email: @user.email)

  if @blocked.save 
    redirect_to friendships_path
  else
    redirect_to users_path
  end


  end


#this method reports a user from the system

  def report_user
    @user = current_user 
    @friend = User.find( params[:user_id])

  @reported = ReportUser.new(:reporter_id => @user.id , :reported_id => @friend.id , :reporter => @user.username , :reported => @friend.username)

  if @reported.save
    flash[:notice] = "User has been reported!"
    redirect_to friendships_path
  else 
    flash[:notice] = "You have already reported this user !"
    redirect_to users_path
  end 
  end 


      

    # user_params action requires the model user and whenever we want to retrieve the user's parameteres
    # we can do so using this action. Also it prevents a user from hacking into the app and changing the
    # model.
    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username, :gender, :full_name, :password_question, :answer_for_password_question ,:privacy,:image)

    end
end


