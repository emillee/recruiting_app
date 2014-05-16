class Job < ActiveRecord::Base

  attr_reader :job_score
  attr_writer :job_score
  attr_reader :job_score_tracker
  attr_writer :job_score_tracker
  attr_reader :skill_matches
  attr_writer :skill_matches  
  attr_reader :max_score

  before_create :set_is_draft
  before_save { self.full_text = ActionView::Base.full_sanitizer.sanitize(self.full_text) }
  before_save { self.title = self.title.downcase.squish if self.title }
  before_save { self.dept = self.dept.downcase.squish if self.dept }
  before_save { self.sub_dept = self.sub_dept.downcase.squish if self.sub_dept }
  before_save { self.years_exp = self.years_exp.to_s.squish.to_i if self.years_exp }
  
  belongs_to :listing_company, class_name: 'Company', foreign_key: :company_id
  
  has_many :user_job_applicants, class_name: 'UserJob', foreign_key: :applied_job_id
  has_many :users_that_saved_job, class_name: 'UserJob', foreign_key: :saved_job_id
  has_many :users_that_removed_job, class_name: 'UserJob', foreign_key: :removed_job_id

  has_many :applicants, through: :user_job_applicants, source: :user  
  has_many :saved_users, through: :users_that_saved_job, source: :user
  has_many :removed_users, through: :users_that_removed_job, source: :user

  has_many :user_job_preapprovals, class_name: 'UserJobPreapproval', foreign_key: :job_id
  has_many :preapproved_applicants, through: :user_job_preapprovals, source: :user

  has_many :job_skills
  has_many :required_skills, through: :job_skills, source: :job  
  
  include Scrape
  include ImportData
  include RegexMethods
  include Filterable
  include Taxonomy

  scope :keywords, ->(keywords_arr) { Job.joins(:listing_company).where('companies.name @@ :q OR jobs.full_text @@ :q', q:  keywords_arr.join(' ')) }
  scope :dept, ->(dept_arr) { where('jobs.dept IN (?)', dept_arr) }
  scope :sub_dept, ->(sub_dept_arr) { where('jobs.sub_dept IN (?)', sub_dept_arr) }
  scope :years_exp, ->(years_exp_arr) { where('jobs.years_exp <= (?)', years_exp_arr.max) } 
  scope :key_skills, ->(key_skills) { 
    where("to_tsvector('english', title) @@ #{sanitize_query(key_skills)} OR to_tsvector('english', full_text) @@ #{sanitize_query(key_skills)}") 
  }

  def self.sanitize_query(query, conjunction=' || ')
    "(" + tokenize_query(query).map{|t| self.term(t)}.join(conjunction) + ")"
  end

  def self.tokenize_query(query)
    query.split(/(\s|[&|:])+/)
  end 

  def self.term(t)
    # Strip leading apostrophes, they are never legal, "'ok" becomes "ok"
    t = t.gsub(/^'+/,'')
    # Strip any *s that are not at the end of the term
    t = t.gsub(/\*[^$]/,'')
    # Rewrite "sear*" as "sear:*" to support wildcard matching on terms
    t = t.gsub(/\*$/,':*')
    # If the only remaining text is a wildcard, return an empty string
    t = "" if t.match(/^[:* ]+$/)

    "to_tsquery('english', #{quote_value t})"
  end  

  validates :company_id, presence: true

  def self.return_skills(sub_dept_arr)
    skills = []
    sub_dept_arr.each do |sub_dept|
      skills << self.return_skills_by_sub_dept(sub_dept)
    end

    skills.flatten.uniq
  end

  def self.return_skills_by_sub_dept(sub_dept)
    sub_dept = sub_dept.downcase
    jobs = Job.where(sub_dept: sub_dept)
    company_objs = jobs.map(&:listing_company).uniq
    skill_objs = company_objs.select { |c| !c.tech_stack.empty? }.map(&:tech_stack).flatten.uniq
    sub_dept = sub_dept.split(' ').join('-')
    skill_objs = skill_objs.select { |s| s.skill_sub_dept ==  sub_dept }
    skill_objs
  end
  
  def import_data
    self.get_text_from_link if (self.full_text.nil? || self.full_text.empty?)
    self.get_title if (self.title.nil? || self.title.empty?)
    self.clean_extra_text_and_periods
    self.get_dept if (self.dept.nil? || self.dept.empty?)
    self.get_sub_dept if (self.sub_dept.nil? || self.sub_dept.empty?)
    self.get_years_exp if (self.years_exp.nil? || self.years_exp.to_s.empty?)
    # self.get_req_skills
  end

  # RANKING-------------------------------------------------------------------------------

  def self.rank_jobs(jobs, user)
    return jobs if user.job_settings[:key_skills].nil?

    skill_points_weighting = 2
    industry_points_weighting = 1

    jobs.each do |job|
      job.job_score ||= 0
      skill_matches ||= 0

      # this is a collection of skill object id's
      user_tech_stack = user.job_settings[:key_skills].map(&:to_i)
      job_tech_stack = job.listing_company.tech_stack.map(&:id)
      
      skill_matches_arr = (user_tech_stack.uniq & job_tech_stack.uniq)
      job.job_score += skill_points_weighting * skill_matches_arr.count
      if job.listing_company.category_code && user.job_prefs[:company_industry]
        job.job_score += industry_points_weighting if user.job_prefs && 
          user.job_prefs[:company_industry].map(&:downcase).include?(job.listing_company.category_code.downcase)
      end
    end

    jobs.sort! { |a,b| b.job_score <=> a.job_score }
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
