class AlterColumnInJobs < ActiveRecord::Migration
  def change
    remove_column :jobs, :sub_debt
    add_column :jobs, :sub_dept, :string
  end
end
