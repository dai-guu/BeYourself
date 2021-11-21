class RemoveIsValidFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_valid, :boolean
  end
end
