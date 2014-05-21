class AddSearchIndexToJobs < ActiveRecord::Migration
  def up
  	execute "create index jobs_title on jobs using gin(to_tsvector('english', title))"
  	execute "create index jobs_full_text on jobs using gin(to_tsvector('english', full_text))"
  end

  def down
  	execute "drop index jobs_title"
  	execute "drop index jobs_full_text"
  end
end
