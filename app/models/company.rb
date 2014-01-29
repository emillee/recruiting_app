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
  
  # To fix: this needs a lot of work
  def self.search(settings_hash)
    if settings_hash.empty?
      companies = self.all
    else
      if settings_hash[:keywords]
        settings_hash[:keywords].each do |search_query|
          companies = where("name @@ :q", q: search_query)      
        end
      else
        companies = self.all
      end
    end
    
    companies
  end
  
  def self.all_company_names
    return @all_company_names unless @all_company_names.nil?
    
    @all_company_names = []
    self.all.each do |co|
      @all_company_names << co.name
    end
    
    @all_company_names.uniq!
    @all_company_names
  end
    
  
end
