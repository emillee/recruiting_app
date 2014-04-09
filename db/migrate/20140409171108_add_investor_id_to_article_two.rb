class AddInvestorIdToArticleTwo < ActiveRecord::Migration
  def change
    add_column :articles, :investor_id, :integer
  end
end
