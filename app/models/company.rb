class Company < ActiveRecord::Base
  
  validates :name, presence: true
  
  scope :career_page_available, lambda { where('companies.career_page_link IS NOT NULL AND 
    companies.career_page_link != ?', 'NA') }
  
  has_many(
    :job_listings,
    class_name: 'Job',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  include ApiCalls
  
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
    all_names = Company.all.map(&:name).uniq!
    all_names
  end
  
end








