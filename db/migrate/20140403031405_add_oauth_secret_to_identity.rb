class AddOauthSecretToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :oauth_secret, :string
  end
end
