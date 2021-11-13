class AddHashbodyToPostImages < ActiveRecord::Migration[5.2]
  def change
    add_column :post_images, :hashbody, :text
  end
end
