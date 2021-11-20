class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   has_many :post_images, dependent: :destroy
   has_many :post_comments, dependent: :destroy
   has_many :likes, dependent: :destroy
   attachment :profile_image
   has_many :favorites, dependent: :destroy

   has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
   has_many :followers, through: :reverse_of_relationships, source: :follower


   has_many :relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
   has_many :followings, through: :relationships, source: :followed

   def follow(user_id)
    relationships.create(followed_id: user_id)
   end

   def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
   end

   def following?(user)
    followings.include?(user)
   end


  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end





end
