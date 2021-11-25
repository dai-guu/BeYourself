class FavoritesController < ApplicationController
  def create
    @post_image = PostImage.find(params[:post_image_id])
    favorite = @post_image.favorites.new(user_id: current_user.id)
    favorite.save
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    favorite = @post_image.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end
end
