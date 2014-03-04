class AddDefaultToJobFilters < ActiveRecord::Migration
  def change
    remove_column :users, :job_filters
    add_column :users, :job_filters, :hstore, default: ''
  end
end
