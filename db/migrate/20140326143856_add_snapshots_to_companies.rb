class AddSnapshotsToCompanies < ActiveRecord::Migration
  def change
    add_attachment :companies, :snapshots
  end
end
