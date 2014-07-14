class ChangeVotesToRecs < ActiveRecord::Migration
  def change
  	rename_column :articles, :votes, :recs
  end
end
