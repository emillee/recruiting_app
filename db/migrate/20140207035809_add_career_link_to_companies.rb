class AddCareerLinkToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :career_page_link, :string
  end
end
