class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :image_id
      t.text :introduction
      t.integer :user_id

      t.timestamps
    end
  end
end
