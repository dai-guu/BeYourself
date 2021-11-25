class LikesController < ApplicationController
  def create
    @post_image = PostImage.find(params[:post_image_id])
    like = @post_image.likes.new(user_id: current_user.id)
    like.save
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    like = @post_image.likes.find_by(user_id: current_user.id)
    like.destroy
  end
end
