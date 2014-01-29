class ChangeJobsAndCompaniesTable < ActiveRecord::Migration
  def change
    remove_column :jobs, :company
    remove_column :jobs, :description
    remove_column :jobs, :category
    remove_column :jobs, :sub_category
    remove_column :jobs, :background
    remove_column :jobs, :experience_required
    
    add_column :jobs, :dept, :string
    add_column :jobs, :sub_debt, :string
  end
end
