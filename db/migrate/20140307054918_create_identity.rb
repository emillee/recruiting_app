class CreateIdentity < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user_id
      t.string :uid
      t.string :provider
    end
  end
end
