class AddSnapshotsToInvestors < ActiveRecord::Migration
  def change
    add_attachment :investors, :snapshots
  end
end
