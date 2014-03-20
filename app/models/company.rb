class Company < ActiveRecord::Base
  
  validates :name, presence: true
  
  scope :keywords, ->(keywords) { where('companies.name @@ :q OR companies.overview @@ :q', q: keywords) }
  scope :page_available, ->(arg) { where('companies.career_page_link IS NOT NULL AND 
    companies.career_page_link != ?', 'NA') }
  scope :page_unavailable, ->(arg) { where('companies.career_page_link = ?', 'NA') }
  scope :page_blank, ->(arg) { where('companies.career_page_link IS NULL') }
  scope :is_hiring, ->(arg){ Company.joins(:job_listings) }
  
  has_many(
    :job_listings,
    class_name: 'Job',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  has_many(
    :employees,
    class_name: 'User',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  include ApiCalls
  include Filterable
  
  
  def self.all_company_names
    all_names = Company.all.map(&:name).uniq!
    all_names
  end
  
end








