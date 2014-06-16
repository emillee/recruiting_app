class AlterUserProfileColumnNames < ActiveRecord::Migration
  def change
  	rename_column :users, :personal_blog, :personal_blog_url
  	add_column :users, :stack_overflow, :string
  end
end
