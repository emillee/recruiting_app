class ChangeCheckSizeColumnToFloat < ActiveRecord::Migration
  def change
    remove_column :investors, :check_size
    add_column :investors, :check_size, :decimal, array: true, default: []
  end
end
