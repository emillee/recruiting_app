class AddGithubFieldsToProspects < ActiveRecord::Migration
  def change
  	add_column :prospects, :company, :string
  	add_column :prospects, :website, :string
  	add_column :prospects, :github_followers, :integer
  	add_column :prospects, :github_stars, :integer
  	add_column :prospects, :github_following, :integer
  end
end
