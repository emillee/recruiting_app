class Company < ActiveRecord::Base
  validates :name, presence: true
  
  has_many(
    :job_listings,
    class_name: 'Job',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  def self.search_name(query)
    rank = <<-RANK
      ts_rank(to_tsvector(name), plainto_tsquery(#{sanitize(query)}))
    RANK
    
    where("name @@ :q", q: "%#{query}").order("#{rank} DESC")
  end
  
end
