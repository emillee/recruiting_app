class AddNeighborhoodToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :neighborhood, :string
  end
end
