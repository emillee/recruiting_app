class AddFollowUpToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :howl_action, :text
  end
end
