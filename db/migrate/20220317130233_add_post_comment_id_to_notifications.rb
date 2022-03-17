class AddPostCommentIdToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :post_comment_id, :integer
  end
end
