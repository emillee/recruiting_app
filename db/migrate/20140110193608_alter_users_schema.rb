class AlterUsersSchema < ActiveRecord::Migration
  def change
    remove_column :jobs, :title_specific
    add_column :jobs, :title, :string
    
    remove_column :jobs, :department
    add_column :jobs, :category, :string
    add_column :jobs, :sub_category, :string
    
    add_column :jobs, :background, :string
  end
end

# 
# create_table "jobs", force: true do |t|
#   t.string   "title_specific"
#   t.string   "department"
#   t.string   "company"
#   t.text     "description"
#   t.string   "link"
#   t.datetime "created_at"
#   t.datetime "updated_at"
#   t.string   "experience_required"
# end
