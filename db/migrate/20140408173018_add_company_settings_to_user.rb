class AddCompanySettingsToUser < ActiveRecord::Migration
  def change
    add_column :users, :company_settings, :text
  end
end
