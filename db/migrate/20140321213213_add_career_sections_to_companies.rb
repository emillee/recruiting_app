class AddCareerSectionsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :career_sections, :hstore, default: {}
  end
end
