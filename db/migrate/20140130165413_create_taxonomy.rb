class CreateTaxonomy < ActiveRecord::Migration
  def change
    create_table :taxonomies do |t|
      t.string :title
    end
  end
end
