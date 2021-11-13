class PostImagesController < ApplicationController

  def new
    @post_image = PostImage.new


  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if
     @post_image.save
     redirect_to post_images_path
    else
     render('post_images/new')
    end
  end

  def index
    @post_images = PostImage.page(params[:page]).reverse_order
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    @user = @post_image.user
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

 def edit
     @post_image = PostImage.find(params[:id])
 end

 def update
    post_image = PostImage.find(params[:id])
    post_image.update(post_image_params)
    redirect_to post_image_path(post_image)
 end

 def hashtag
    @user = current_user
    if params[:name].nil?
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @post_image = @hashtag.post_images.page(params[:page]).per(20).reverse_order
      @hashtags = Hashtag.all.to_a.group_by{ |hashtag| hashtag.post_images.count}
    end
 end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :body, :hashbody, :user_id, :image, hashtag_ids: [])
  end


end
