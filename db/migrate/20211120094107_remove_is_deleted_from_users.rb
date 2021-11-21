class RemoveIsDeletedFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_deleted, :boolean
  end
end
