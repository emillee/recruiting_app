class AddDefaultsToArticles < ActiveRecord::Migration
  def change
    change_column :articles, :title, :string, default: ''
    change_column :articles, :body, :text, default: ''
  end
end
