class AddCompanyAndInvestorIdToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :company_id, :integer
  	add_column :articles, :investor_id, :integer
  end
end
