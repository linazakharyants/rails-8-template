class RenameAvatarToAvatarUrlInUsers < ActiveRecord::Migration[8.0]
  def change
    rename_column :users, :avatar, :avatar_url
  end
end
