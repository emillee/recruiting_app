class AddProspectSettingsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :prospect_settings, :text
  end
end
