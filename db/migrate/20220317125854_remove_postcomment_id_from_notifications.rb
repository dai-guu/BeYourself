class RemovePostcommentIdFromNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :postcomment_id, :integer
  end
end
