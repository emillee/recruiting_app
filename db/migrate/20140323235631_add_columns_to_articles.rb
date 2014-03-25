class AddColumnsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :tag_id, :integer
    add_column :articles, :company_id, :integer
  end
end
