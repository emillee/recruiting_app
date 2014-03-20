class User < ActiveRecord::Base
  
  attr_reader :password # for password length validation
  
  validates :password, length: { minimum: 6, allow_nil: true }, unless: :guest?
  validates :email, presence: true, unless: :guest?
  # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  before_save { self.email = self.email.downcase unless self.email.nil? }
  before_create :create_session_token
  
  after_create :set_admin_to_false
  
  serialize :job_settings, Hash
  after_initialize :initialize_job_settings
  store_accessor :job_filters, :keywords, :dept, :sub_dept, :experience
  
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
    default_url: '/images/:style/missing.png'
  
  belongs_to(
    :employer,
    class_name: 'Company',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  has_many(
    :user_jobs,
    class_name: 'UserJob',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :jobs_viewed,
    through: :user_jobs,
    source: :job_applied_to
  )
  
  has_many(
    :saved_jobs,
    through: :user_jobs,
    source: :job_saved
  )
  
  has_many(
    :removed_jobs,
    through: :user_jobs,
    source: :removed_job
  )
  
  has_many(
    :user_job_preapprovals,
    class_name: 'UserJobPreapproval',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :preapproved_jobs,
    through: :user_job_preapprovals,
    source: :job
  )
  
  has_many(
    :identities,
    class_name: 'Identity',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :user_skills,
    class_name: 'UserSkill',
    foreign_key: :user_id,
    primary_key: :id
  )

  # Sessions / Authentication------------------------------------------
  def self.new_guest 
    self.new(
      email: "guest", 
      guest: true,
      password: SecureRandom.urlsafe_base64
    )
  end
  
  def password=(password_string)
    @password = password_string # for password length validation
    self.password_digest = BCrypt::Password.create(password_string)
  end
  
  def password_match?(password_string)
    BCrypt::Password.new(self.password_digest).is_password?(password_string)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
  end
  
  def inputs_from_omniauth(auth)
    self.fname, self.lname = auth.info.name.split(' ')[0], auth.info.name.split(' ')[1] if auth.info.name
    self.email = auth.info.email if auth.info.email
    self.save!
    self
  end

  # Social-------------------------------------------------------------------------
  
  def get_facebook_graph
    base_uri = "https://graph.facebook.com/me?access_token=" + "#{self.get_oauth_token}"
    HTTParty.get(base_uri)
  end
  
  def get_oauth_token
    self.identities.where(provider: 'facebook').first.oauth_token
  end
  
  def get_mutual_connections(other_user)
    base_uri = "https://graph.facebook.com/me" 
    other_person = "/mutualfriends/#{other_user.get_fb_uid}"
    oauth = "?access_token=#{self.get_oauth_token}"
    HTTParty.get(base_uri + other_person + oauth)
  end
  
  def get_fb_friends
    base_uri = "https://graph.facebook.com/me/friends" 
    oauth = "?access_token=#{self.get_oauth_token}"
    HTTParty.get(base_uri + oauth)    
  end
  
  def get_fb_uid
    self.identities.where(provider: 'facebook').first.uid
  end
  
  # https://graph.facebook.com/me/friends?fields=id,name,work&access_token=CAACEdEose0cBANqx5nava53w4kC1z8yRYEMFPSgUhUcisbCAuBEo8D0NZC0WAr2NKsFIf5lDzLMrW9Ag0ObXIpGTbOP5Mt1GQIgftXsgzLLPuIVyfPJnJ9tkp6zgooEIKN66os5FwZCcgfuviZAqfmeNTo9BiKe5xZCC0UJRGX1qlZBDpYm1GAxOy4h2hpcsZD
  
  # Private------------------------------------------------------------------------
  private
  
    def create_session_token
      self.session_token = SecureRandom.urlsafe_base64
    end
  
     def initialize_job_settings
       self.job_settings ||= '{}'
    end
    
    def set_admin_to_false
      self.is_admin = false
      self.save
    end
  
end
