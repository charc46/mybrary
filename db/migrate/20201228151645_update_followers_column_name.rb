class UpdateFollowersColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :follows, :foller_id, :follower_id
  end
end
