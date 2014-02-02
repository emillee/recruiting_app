class AddLevelAndBaseTitleToTaxonomies < ActiveRecord::Migration
  def change
    add_column :taxonomies, :level, :string
    add_column :taxonomies, :base_title, :string
  end
end
