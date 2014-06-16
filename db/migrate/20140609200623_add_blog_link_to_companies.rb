class AddBlogLinkToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :blog_link, :string
  end
end
