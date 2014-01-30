class Job < ActiveRecord::Base
  
  before_create :set_is_draft
  
  belongs_to(
    :listing_company,
    class_name: 'Company',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  # populate a job listing from a link
  def input_job_data
    self.get_text
    self.get_title
    self.get_dept
    self.get_sub_dept
  end
  
  def get_text
    html = open(link)
    doc = Nokogiri.HTML(html)
    doc.css('script').remove
    text = doc.at('body').inner_text
    self.full_text = text.squish
    self.save
  end

  def get_company
    Company.all.each do |company|
      self.company_id = company.id if self.first_thirty.match(/#{company.name}/i)
    end
    
    self.save
  end
  
  def get_title
    Job.all_unique_titles.each do |uniq_title|
      self.title = uniq_title if self.first_thirty.match(/#{uniq_title}/i)
    end
    
    self.save
  end
  
  def get_dept
    if self.title
      job = Job.all.find { |job| job.title == self.title && !job.dept.nil? }
    end
    
    self.dept = job.dept if job.dept
    self.save
  end

  def get_sub_dept
    if self.title
      job = Job.all.find { |job| job.title == self.title && !job.sub_dept.nil? }
    end
    
    self.sub_dept = job.sub_dept if job.sub_dept
    self.save
  end
  
  #-------------------------------------------------------
  
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
      if settings_hash[:dept] 
        jobs = where("dept IN (?)", settings_hash[:dept])
      else
        jobs = self.all
      end
      
      if !settings_hash[:experience].nil?
        jobs = jobs.where("years_exp IN (?)", settings_hash[:experience])
      end
      
      if !settings_hash[:keywords].nil?
        settings_hash[:keywords].each do |search_query|
          jobs = jobs.where("name @@ :q OR full_text @@ :q", q: search_query).joins(:listing_company)
        end      
      end
    end
    
    jobs
  end
  
  
  # UTILITY-------------------------------------------------------------------------------
  
  def first_thirty
    self.full_text.split(' ')[0..30].join(' ')
  end
  
  
  def self.all_unique_titles
    unique_titles = Job.all.map(&:title).uniq!
    unique_titles.sort_by(&:length).reverse
    unique_titles
  end
  
  
  def self.unique_depts
    depts = Job.all.map(&:dept).uniq!
    depts
  end
  
  #-------------------------------------------------------------------------------
  private
  
    def set_is_draft
      self.is_draft = true
    end	 
    
end
