class AddLinkToArticle < ActiveRecord::Migration
  def change
  	add_column :articles, :link, :string
  end
end
