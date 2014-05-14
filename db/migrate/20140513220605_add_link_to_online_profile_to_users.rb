class AddLinkToOnlineProfileToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :link_to_online_profile, :string
  end
end
