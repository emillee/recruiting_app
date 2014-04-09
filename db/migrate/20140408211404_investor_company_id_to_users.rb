class InvestorCompanyIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :investor_company_id, :integer
  end
end
