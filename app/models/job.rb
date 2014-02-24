class Job < ActiveRecord::Base
  
  before_create :set_is_draft
  
  belongs_to(
    :listing_company,
    class_name: 'Company',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  has_many(
    :user_job_applicants,
    class_name: 'UserJob',
    foreign_key: :applied_job_id,
    primary_key: :id
  )
  
  has_many(
    :users_that_saved_job,
    class_name: 'UserJob',
    foreign_key: :saved_job_id,
    primary_key: :id
  )
   
  has_many(
    :saved_jobs,
    class_name: 'UserJob',
    foreign_key: :saved_job_id,
    primary_key: :id
  )
  
  has_many(
    :applicants,
    through: :user_job_applicants,
    source: :user
  )
  
  has_many(
    :saved_users,
    through: :users_that_saved_job,
    source: :user
  )
  
  include Scrape
  include ImportData
  include RegexMethods
  
  
  def import_data
    self.get_text_from_link
    self.get_title
    self.clean_extra_text_and_periods
    self.get_dept
    self.get_sub_dept
    self.get_years_exp
  end
  
  # CLASSIFIER -------------------------------------------------------------------------------
  
  def self.search(settings_hash)
    if settings_hash.empty?
      jobs = self.all
    else
      if settings_hash[:dept] 
        jobs = where("dept IN (?)", settings_hash[:dept])
      else
        jobs = self.all
      end

      if !settings_hash[:sub_dept].nil?
        jobs = jobs.where("sub_dept IN (?)", settings_hash[:sub_dept])
      end
      
      if !settings_hash[:experience].nil?
        jobs = jobs.where("years_exp < (?)", settings_hash[:experience].max)
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
  
  def classify_level(text)
    expert = YAML::load_file("#{Rails.root}/app/assets/ml_data/expert.yml")
    solid = YAML::load_file("#{Rails.root}/app/assets/ml_data/solid.yml")
    working_knowledge = YAML::load_file("#{Rails.root}/app/assets/ml_data/working_knowledge.yml")
    
    classifier = Classifier::Bayes.new('Expert', 'Solid', 'Working Knowledge')
    
    expert.each { |exp| classifier.train_expert exp }
    solid.each { |sol| classifier.train_solid sol }
    working_knowledge.each { |wk| classifier.train_working_knowledge wk }
    
    classifier.classify text
  end
   
  #-------------------------------------------------------------------------------
  private
  
    def set_is_draft
      self.is_draft = true
    end	 
    
   
end
