class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page]).reverse_order

    @post_images = @user.post_images.order(created_at: :desc)
    favorites = Favorite.where(user_id: current_user.id).order(created_at: :desc).pluck(:post_image_id)
    @favorites = PostImage.find(favorites)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def unsubscribe
    @user = User.find_by(email: params[:email])
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email, :introduction)
  end
end
