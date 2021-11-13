class CreateHashtagPostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtag_post_images do |t|
      t.references :post_image, foreign_key: true
      t.references :hashtag, foreign_key: true

      t.timestamps
    end
  end
end
