class RemoveCaptionFromPostImages < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_images, :caption, :text
  end
end
