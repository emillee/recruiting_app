namespace :search_suggestions do
  desc "Generate description suggestions from jobs"
  task index: :environment do
    SearchSuggestion.index_jobs
  end
end