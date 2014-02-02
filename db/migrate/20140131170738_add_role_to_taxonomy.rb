class AddRoleToTaxonomy < ActiveRecord::Migration
  def change
    add_column :taxonomies, :dept, :string
  end
end
