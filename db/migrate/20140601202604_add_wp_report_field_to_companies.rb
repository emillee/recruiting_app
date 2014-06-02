class AddWpReportFieldToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :size_commentary, :text
  	add_column :companies, :team_soundbite, :string
  	add_column :companies, :team_commentary, :text
  	add_column :companies, :funding_commentary, :text
  	add_column :companies, :outlook, :string
  	add_column :companies, :outlook_commentary, :text

  end
end
