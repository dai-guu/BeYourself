class Hashtag < ApplicationRecord
  validates :hashname, presence: true, length: { maximum: 50 }
  has_many :hashtag_post_images, dependent: :destroy
  has_many :post_images, through: :hashtag_post_images
end
