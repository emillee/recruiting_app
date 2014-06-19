class AddCompanyTechBlog < ActiveRecord::Migration
  def change
  	rename_column :companies, :blog_link, :company_blog_url
  	add_column :companies, :tech_blog_url, :string
  end
end
