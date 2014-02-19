class Company < ActiveRecord::Base
  
  validates :name, presence: true
  
  scope :keyword_search, ->(keywords) { where('companies.name @@ :q', q: keywords) }
  scope :page_available, -> { where('companies.career_page_link IS NOT NULL AND 
    companies.career_page_link != ?', 'NA') }
  scope :page_unavailable, -> { where('companies.career_page_link = ?', 'NA') }
  scope :page_blank, -> { where('companies.career_page_link IS NULL') }
  
  has_many(
    :job_listings,
    class_name: 'Job',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  include ApiCalls
  
  
  def self.all_company_names
    all_names = Company.all.map(&:name).uniq!
    all_names
  end
  
  def self.scopes
    [
      'page_available',
      'unavailable',
      'page_blank'
    ]
  end
  
end








