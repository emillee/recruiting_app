class RemoveColumnsFromArticles < ActiveRecord::Migration
  def change
  	remove_column :articles, :author_id
  	remove_column :articles, :tag_id
  	remove_column :articles, :investor_id
  	remove_column :articles, :company_id
  end
end
