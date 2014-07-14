class AddVotesToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :votes, :integer, default: 0
  end
end
