class AddTwitterFollowersCountToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :twitter_followers, :integer
  end
end
