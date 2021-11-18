class AddCategoryToPostImages < ActiveRecord::Migration[5.2]
  def change
    add_column :post_images, :category, :string
  end
end
