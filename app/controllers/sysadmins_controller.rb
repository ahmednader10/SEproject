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

  def merge
  end

  def createMerge
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
