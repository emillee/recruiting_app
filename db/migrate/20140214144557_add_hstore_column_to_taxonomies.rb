class AddHstoreColumnToTaxonomies < ActiveRecord::Migration
  def change
    add_column :taxonomies, :expert_phrases, :hstore
  end
end
