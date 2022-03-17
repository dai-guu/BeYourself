class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :visitor, foreign_key: true
      t.references :visited, foreign_key: true
      t.references :post_image, foreign_key: true
      t.references :postcomment, foreign_key: true
      t.string :action
      t.boolean :checked

      t.timestamps
    end
  end
end
