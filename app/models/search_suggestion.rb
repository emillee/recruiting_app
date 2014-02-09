class SearchSuggestion < ActiveRecord::Base
  
  def self.terms_for(prefix)
    suggestions = where("term like ?", "#{prefix}_%")
    suggestions.order("popularity desc").limit(10).pluck(:term)
  end
  
  def self.index_jobs
    Job.find_each do |job|
      index_term(job.dept) if job.dept
      index_term(job.sub_dept) if job.sub_dept
    end
  end
  
  def self.index_term(term)
    where(term: term.downcase).first_or_initialize.tap do |suggestion|
      suggestion.increment! :popularity
    end
  end
  
end
