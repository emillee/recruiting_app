class AddOverviewToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :year_founded, :integer
    add_column :companies, :overview, :text
  end
end
