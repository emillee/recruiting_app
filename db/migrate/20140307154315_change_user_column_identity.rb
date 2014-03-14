class ChangeUserColumnIdentity < ActiveRecord::Migration
  def change
    remove_column :identities, :user_id_id
    add_column :identities, :user_id, :integer
  end
end
