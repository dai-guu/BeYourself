class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post_image

  validates_uniqueness_of :post_image_id, scope: :user_id
end
