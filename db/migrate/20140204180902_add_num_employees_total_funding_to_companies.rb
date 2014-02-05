class AddNumEmployeesTotalFundingToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :num_employees, :integer
    add_column :companies, :total_money_raised, :string
  end
end
