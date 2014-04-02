class Company < ActiveRecord::Base
  
  validates :name, presence: true
  attr_reader :article_id
  
  scope :keywords, ->(keywords) { where('companies.name @@ :q OR companies.overview @@ :q', q: keywords) }
  scope :page_available, ->(arg) { where('companies.career_page_link IS NOT NULL AND 
    companies.career_page_link != ?', 'NA') }
  scope :page_unavailable, ->(arg) { where('companies.career_page_link = ?', 'NA') }
  scope :page_blank, ->(arg) { where('companies.career_page_link IS NULL') }
  scope :is_hiring, ->(arg){ Company.joins(:job_listings) }
  
  has_attached_file :snapshots, styles: { original: '200x400', medium: '300x300', large: '300x500' }, 
    path: ":rails_root/public/system/:class/:attachment/:id_partition/:style/:normalized_companypic_file_name.:extension",
    url: "/system/:class/:attachment/:id_partition/:style/:normalized_companypic_file_name.:extension" 

  
  Paperclip.interpolates :normalized_companypic_file_name do |attachment, style|
    attachment.instance.normalized_companypic_file_name
  end  
  
  def store_article_id_temporarily(article_id)
    @article_id = article_id
  end
  
  def normalized_companypic_file_name
    "id-#{self.id}-name-#{self.name}-articleid-#{self.article_id}"
  end

    
  validates_attachment_content_type :snapshots, content_type: /\Aimage\/.*\Z/
  
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
  
  has_many(
    :articles,
    class_name: 'Article',
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








