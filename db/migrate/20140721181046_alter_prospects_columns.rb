class AlterProspectsColumns < ActiveRecord::Migration
  def change
  	rename_column :prospects, :city, :city_github
  	rename_column :prospects, :date_joined, :date_joined_github
  	rename_column :prospects, :company, :company_github
  	rename_column :prospects, :website, :website_github
  	add_column :prospects, :li_url, :string
  	add_column :prospects, :li_title, :string
  	add_column :prospects, :li_company, :string
  end
end
