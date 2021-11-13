class AddBodyToPostImages < ActiveRecord::Migration[5.2]
  def change
    add_column :post_images, :body, :text
  end
end
