class AddJobHstore < ActiveRecord::Migration
  def change
    add_column :users, :job_filters, :hstore
  end
end
