class AddCheckSizeToInvestors < ActiveRecord::Migration
  def change
    add_column :investors, :check_size, :integer, array: true, default: []
  end
end
