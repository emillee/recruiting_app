class AddProfileUrlsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :linkedin_url, :string
  	add_column :users, :github_url, :string
  	add_column :users, :behance_url, :string
  	add_column :users, :personal_blog, :string
  	add_column :users, :twitter_username, :string
  end
end
