class AddGithubSkillsReposToProspects < ActiveRecord::Migration
  def change
  	add_column :prospects, :num_repos, :integer
  	add_column :prospects, :github_languages, :string, array: true, default: '{}'
  	add_column :prospects, :yrs_on_github, :float
  end
end
