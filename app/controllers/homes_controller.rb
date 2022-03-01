class HomesController < ApplicationController
  def top
  end

  def about
  end

  def unsubscribe
    @user = User.find_by(name: params[:name])
  end

  def withdraw
    @user = User.find_by(name: params[:name])
    @user.update(is_valid: false)
    reset_session
    redirect_to root_path
  end

  def timeline
    @feeds = PostImage.where(user_id: [current_user.id, *current_user.following_ids])
  end
end
