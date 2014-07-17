class Company < ActiveRecord::Base
  
  attr_reader :article_id

  validates :name, presence: true
  
  scope :keywords, ->(keywords) { where('companies.name @@ :q OR companies.overview @@ :q', q: keywords) }
  scope :page_available, ->(arg) { where('companies.career_page_link IS NOT NULL AND 
    companies.career_page_link != ?', 'NA') }
  scope :page_unavailable, ->(arg) { where('companies.career_page_link = ?', 'NA') }
  scope :page_blank, ->(arg) { where('companies.career_page_link IS NULL') }
  scope :is_hiring, ->(arg){ Company.joins(:job_listings) }

  has_many :job_listings, class_name: 'Job', foreign_key: :company_id
  has_many :employees
  has_many :articles
  has_many :object_skills
  has_many :tech_stack, through: :object_skills, source: :skill

  include ApiCalls
  include Filterable
  include Scrape
  
  has_attached_file :snapshots, styles: { original: '200x400', medium: '300x300', large: '300x500' }, 
    path: ":rails_root/public/system/:class/:attachment/:id_partition/:style/:normalized_companypic_file_name.:extension",
    url: "/system/:class/:attachment/:id_partition/:style/:normalized_companypic_file_name.:extension" 
    
  Paperclip.interpolates :normalized_companypic_file_name do |attachment, style|
    attachment.instance.normalized_companypic_file_name
  end  

  has_attached_file :logo, styles: { medium: '300x300>', thumb: '100x100>' },
    default_url: '/images/app_images/missing_company_logo.jpg'
    
  validates_attachment_content_type :snapshots, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/    

  def return_job_links
    if self.career_page_link
      html = HTTParty.get(self.career_page_link, verify: false)
      doc = Nokogiri.HTML(html)
      doc.css('script').remove
      doc = doc.css('body')
      links = doc.css('a')
    end
  end

  def self.companies_with_job_listings
    Company.select { |c| c.job_listings.any? }
  end
  
  # reads this above with attr_read  
  def store_article_id_temporarily(article_id)
    @article_id = article_id
  end
  
  def normalized_companypic_file_name
    "id-#{self.id}-name-#{self.name.downcase.gsub(' ', '-')}-articleid-#{self.article_id}"
  end  
  
  def self.all_company_names
    all_names = Company.all.map(&:name).uniq!
    all_names
  end

  def next
    Company.where("id > ?", self.id).order("id ASC").first
  end
  
  def prev
    Company.where("id < ?", self.id).order("id DESC").first
  end

end








