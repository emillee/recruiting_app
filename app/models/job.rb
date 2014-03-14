class Job < ActiveRecord::Base
  
  before_create :set_is_draft
  
  belongs_to :listing_company,
             class_name: 'Company',
             foreign_key: :company_id,
             primary_key: :id

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
  
  has_many(
    :user_job_preapprovals,
    class_name: 'UserJobPreapproval',
    foreign_key: :job_id,
    primary_key: :id
  )
  
  has_many(
    :preapproved_applicants,
    through: :user_job_preapprovals,
    source: :user
  )
  
  include Scrape
  include ImportData
  include RegexMethods
  include Filterable
  include Taxonomy

  scope :keywords, ->(keywords_arr) { Job.joins(:listing_company).where('companies.name @@ :q OR jobs.full_text @@ :q', q:  keywords_arr.join(' ')) }
  scope :dept, ->(dept_arr) { where('jobs.dept IN (?)', dept_arr) }
  scope :sub_dept, ->(sub_dept_arr) { where('jobs.sub_dept IN (?)', sub_dept_arr) }
  scope :years_exp, ->(years_exp_arr) { where('jobs.years_exp < (?)', years_exp_arr.max) } 
  
  validates :company_id, presence: true
  
  def import_data
    self.get_text_from_link
    self.get_title
    self.clean_extra_text_and_periods
    self.get_dept
    self.get_sub_dept
    self.get_years_exp
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
