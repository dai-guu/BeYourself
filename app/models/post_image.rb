class PostImage < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :image, presence: true

  has_many :likes, dependent: :destroy
  def favorited_by?(user)
    likes.where(user_id: user.id).exists?
  end

  has_many :hashtag_post_images, dependent: :destroy
  has_many :hashtags, through: :hashtag_post_images

  has_many :favorites, dependent: :destroy
  def bookmarked_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  after_create do
    post_image = PostImage.find_by(id: id)
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post_image.hashtags << tag
    end
  end

  # 更新アクション
  before_update do
    post_image = PostImage.find_by(id: id)
    post_image.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post_image.hashtags << tag
    end
  end

  def self.looks(word, search)
    @post_image = PostImage.all
    if search == "perfect_match"
      @post_image = PostImage.where("title LIKE?", "#{word}")
    elsif search == "partial_match"
      @post_image = PostImage.where("title LIKE?", "%#{word}%")
    else
      @post_image
    end
  end
end
