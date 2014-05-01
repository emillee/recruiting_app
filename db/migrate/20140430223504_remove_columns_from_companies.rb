class RemoveColumnsFromCompanies < ActiveRecord::Migration
  def change
  	remove_columns :companies, :career_sections
  end
end
