class AddColumnsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :years_exp, :integer
    add_column :jobs, :key_skill_one, :string
    add_column :jobs, :key_skill_two, :string
  end
end
