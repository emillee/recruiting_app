class DropTables < ActiveRecord::Migration
  def change
    drop_table :searches
  end
end
