class Job < ActiveRecord::Base
  
  before_create :set_is_draft
  
  belongs_to(
    :listing_company,
    class_name: 'Company',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  # populate a job listing from a link
  
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
    unique_titles = Job.all.map(&:title).compact!
    unique_titles.uniq!
    unique_titles.sort_by(&:length).reverse
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
