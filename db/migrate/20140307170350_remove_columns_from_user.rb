class RemoveColumnsFromUser < ActiveRecord::Migration
  def change
    remove_column :user, :oauth_token
    remove_column :user, :oauth_token_expires_at
  end
end
