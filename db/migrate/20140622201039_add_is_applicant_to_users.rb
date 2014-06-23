class AddIsApplicantToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :is_applicant, :boolean
  	rename_column :users, :guest, :is_guest
  end
end
