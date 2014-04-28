class AddCompanyIdToObjectSkills < ActiveRecord::Migration
  def change
  	add_column :object_skills, :company_id, :integer
  end
end
