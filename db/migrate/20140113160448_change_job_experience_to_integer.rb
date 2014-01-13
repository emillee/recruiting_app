class ChangeJobExperienceToInteger < ActiveRecord::Migration
  def change
    remove_column :jobs, :experience_required, :string
    add_column :jobs, :experience_required, :integer
  end
end
