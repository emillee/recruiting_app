class AddTwitterUsernameToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :twitter_username, :string
    add_column :companies, :category_code, :string
    add_column :companies, :city, :string
  end
end
