class ChangeExperienceColumnToInteger < ActiveRecord::Migration
  def change
    remove_column :jobs, :experience_required
    add_column :jobs, :experience_required, :string
  end
end
