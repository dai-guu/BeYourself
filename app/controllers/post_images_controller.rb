class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      redirect_to post_images_path
    else
      render('post_images/new')
    end
  end

  def index
    @post_images = PostImage.includes([:user]).page(params[:page]).reverse_order
    @all_ranks = PostImage.find(Like.group(:post_image_id).order('count(post_image_id) DESC').limit(3).pluck(:post_image_id))
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    @user = @post_image.user
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to user_path(current_user)
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
      @hashtags = Hashtag.all.to_a.group_by { |hashtag| hashtag.post_images.count }
    else
      @hashtag = Hashtag.find_by(hashname: params[:name])
      @post_image = @hashtag.post_images.page(params[:page]).per(20).reverse_order
      @hashtags = Hashtag.all.to_a.group_by { |hashtag| hashtag.post_images.count }
    end
  end

  def all
    @alls = PostImage.where(category: "all")
    @post_images = PostImage.page(params[:page]).reverse_order
  end

  def men
    @mens = PostImage.where(category: "men")
    @post_images = PostImage.page(params[:page]).reverse_order
  end

  def women
    @womens = PostImage.where(category: "women")
    @post_images = PostImage.page(params[:page]).reverse_order
  end

  def kids
    @kidss = PostImage.where(category: "kids")
    @post_images = PostImage.page(params[:page]).reverse_order
  end

  def business
    @businesss = PostImage.where(category: "business")
    @post_images = PostImage.page(params[:page]).reverse_order
  end

  def ranking
    @all_ranks = PostImage.find(Like.group(:post_image_id).order('count(post_image_id) DESC').limit(3).pluck(:post_image_id))
    @post_images = PostImage.order("created_at DESC")
  end

  def search
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:word], params[:search])
    else
      @post_images = PostImage.looks(params[:word], params[:search])
    end
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :body, :hashbody, :category, :user_id, :image, hashtag_ids: [])
  end
end
