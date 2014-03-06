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
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.fname, user.lname = auth.info.name.split(' ')[0], auth.info.name.split(' ')[1]
      user.email = auth.info.email
      user.password = SecureRandom.urlsafe_base64(n=6)
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
  # Private----------------------------------------------------------
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
