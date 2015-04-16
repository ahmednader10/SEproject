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
    user_tmp = User.find_by(email: params[:q])
    @users = User.all
    if !user_tmp
      #@user_tmp.destroy                #has to be solved
      render 'index'
    else
      #render 'edit'
      if user_tmp.destroy
        render 'edit'
      else
        render root_path
      end
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
  end

  def userUnblocked
    @user_to_be_unblocked = User.find_by(email: params[:unblock_user])
    if !@user_to_be_unblocked
      render 'show'
    else
      unblock = Block.find_by(email: @user_to_be_unblocked.email)
      if unblock.destroy
        render unblocked_path
      else
        render 'show'
      end
    end
  end

  def forums
    @forums = Forum.all
  end

  def delete
  end 

  def merge
  end

  def createMerge
    if session[:sysadmin]  != true
      render 'merge'
    else
      if params[:forum][:forum1_id] == params[:forum][:forum2_id]
      flash[:notice] = "Must merge two different forums!"
      render 'merge'
    else
      old_forum_id = params[:forum][:forum2_id]
      new_forum_id = params[:forum][:forum1_id]
      name = params[:forum][:name]
      description = params[:forum][:description]
            
      admins = Admin.where({ forum_id: old_forum_id })
      ideas = Idea.where({ forum_id: old_forum_id })
      memberships = Membership.where({ forum_id: old_forum_id })

      admins.each do |a|
        a.forum_id = new_forum_id
        a.save
      end

      ideas.each do |i|
        i.forum_id = new_forum_id
        i.save
      end

      memberships.each do |m|
        m.forum_id = new_forum_id
        m.save
      end

      old_forum = Forum.where({ id: old_forum_id })
      old_forum.first.destroy

      new_forum = Forum.where({ id: new_forum_id })
      new_forum.first.title = name
      new_forum.first.description = description
      new_forum.first.save

      # For now
      redirect_to('/sysadmins/index')
    end
    end
  end

end
