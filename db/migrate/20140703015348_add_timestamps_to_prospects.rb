class AddTimestampsToProspects < ActiveRecord::Migration
  def change
  	add_column :prospects, :created_at, :datetime
  	add_column :prospects, :updated_at, :datetime
  end
end
