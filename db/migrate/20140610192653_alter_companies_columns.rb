class AlterCompaniesColumns < ActiveRecord::Migration
  def change
  	add_column :companies, :the_big_idea_soundbite, :string
  	rename_column :companies, :the_big_idea, :the_big_idea_commentary
  	add_column :companies, :scale_soundbite, :string
  	rename_column :companies, :size_commentary, :scale_commentary
  	add_column :companies, :culture_soundbite, :string
  	add_column :companies, :culture_commentary, :text
  	remove_column :companies, :outlook
  	rename_column :companies, :outlook_commentary, :wolfpack_commentary
  	remove_column :companies, :funding_commentary

  	add_column :jobs, :technical_problem_commentary, :text
  end
end

