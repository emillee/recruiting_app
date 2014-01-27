class Job < ActiveRecord::Base
  
  before_create :set_is_draft
  belongs_to(
    :listing_company,
    class_name: 'Company',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  # populate a job listing
  def self.create_job_from_link(name, link, title = nil)
    job.company_id = Company.where("name @@ :q", q: name)[0].id || nil
    job = self.new(link: link)
    job.get_text
    job.set_title
    job.set_primary_dept
    job.set_secondary_dept
    
    job.save
  end
  
  def set_title
    first_twenty = self.full_text.split(' ')[0..30].join(' ')
    title_match = nil
    
    self.class.all_unique_titles.each do |title|
      title_match = first_twenty.scan(/title/i)
    end
    
    if title_match
      self.title = title.titleize
      self.save
    end
  end
  
  # NEED TO CHANGE DB
  def set_primary_dept
    if self.title
      dept = Job.find_by_title(self.title).primary_dept
      self.primary_dept = dept unless dept.nil?
      self.save if self.primary_dept
    end
  end
  
  def set_secondary_dept
    if self.title
      dept = Job.find_by_title(self.title).secondary_dept
      self.secondary_dept = dept unless dept.nil?
      self.save if self.secondary_dept
    end
  end
  
  def get_text
    html = open(link)
    doc = Nokogiri.HTML(html)
    doc.css('script').remove
    text = doc.at('body').inner_text
    self.full_text = text.squish
    self.save
  end
  
  #-------------------------------------------------------
  
  def self.unique_categories
    uniques = []

    Job.all.each do |job|
      uniques << job.category if !uniques.include?(job.category)
    end
    
    uniques
  end
  
  def self.import(file)
    Job.delete_all
    
    CSV.foreach(file.path, headers: true) do |row|
      Job.create!(row.to_hash)
    end
  end
  
  def self.search(settings_hash)
    if settings_hash.empty?
      jobs = self.all
    else
      if settings_hash[:category] 
        jobs = where("category IN (?)", settings_hash[:category])
      else
        jobs = self.all
      end
      
      if !settings_hash[:experience].nil?
        jobs = jobs.where("experience_required IN (?)", settings_hash[:experience])
      end
      
      if !settings_hash[:keywords].nil?
        settings_hash[:keywords].each do |search_query|
          jobs = jobs.where("description @@ :q", q: search_query)
        end      
      end
    end
    
    jobs
  end
  
  def self.all_unique_titles
    return @unique_titles unless @unique_titles.nil?
    
    @unique_titles = []
    self.all.each do |job|
      @unique_titles << job.title
    end
    
    @unique_titles.uniq!
    @unique_titles
  end
  
  def self.department_mappings
    
  end
  
  #-------------------------------------------------------------------------------
  private
  def set_is_draft
    self.is_draft = true
  end	 
  
end
