class AddSnapshotsToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :snapshots
  end
end
