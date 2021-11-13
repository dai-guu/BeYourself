class HashtagPostImage < ApplicationRecord
  belongs_to :post_image
  belongs_to :hashtag

  validates :post_image_id, presence: true
  validates :hashtag_id, presence: true
end
