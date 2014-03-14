class AddColumnsToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :oauth_token, :string
    add_column :identities, :oauth_expires_at, :datetime
    remove_column :users, :provider
    remove_column :users, :uid 
  end
end

