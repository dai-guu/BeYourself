class PostCommentsController < ApplicationController
  def create
    @post_image = PostImage.find(params[:post_image_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.post_image_id = @post_image.id
    @post_comment.user_id = current_user.id
    @post_comment.save

    # @post_comment = current_user.comments.build(post_comment_params)
    @post_comment.post_image_id = params[:post_image_id]
    if @post_comment.save
      flash[:success] = 'コメントしました'

      @post_image=@post_comment.post_image
      @post_image.create_notification_comment!(current_user, @post_comment.id)

      redirect_to @post_comment.post_image
    else
      post_comments_get
      render template: 'post_images/show'
    end
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])

    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @post_comment = PostComment.new
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
