class AddOverviewToInvestor < ActiveRecord::Migration
  def change
    add_column :investors, :overview, :text
  end
end
