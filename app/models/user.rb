class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  attachment :profile_image
  has_many :favorites, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  
  has_many :active_notifications, foreign_key:"visitor_id", class_name: "Notification", dependent: :destroy
  has_many :passive_notifications, foreign_key:"visited_id", class_name: "Notification", dependent: :destroy
  
  

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

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.looks(word, search)
    @user = User.all
    if search == "perfect_match"
      @user.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @user.where("name LIKE?", "%#{word}%")
    else
      @user
    end
  end
end
