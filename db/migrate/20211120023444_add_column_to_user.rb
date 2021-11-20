class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change



    add_column :users, :height, :integer
    add_column :users, :birthday, :date
    add_column :users, :age, :integer
    add_column :users, :introduction, :string, limit: 500
    add_column :users, :sex, :integer, null: false, default: 0

  end
end
