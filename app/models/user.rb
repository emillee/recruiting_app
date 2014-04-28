class User < ActiveRecord::Base
  
  attr_reader :password # for password length validation
  attr_reader :user_company # for autocomplete
  attr_reader :article_id
  
  validates :password, length: { minimum: 6, allow_nil: true }, unless: :guest?
  validates :email, presence: true, unless: :guest?
  # validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  before_save { self.email = self.email.downcase unless self.email.nil? }
  before_save { self.job_settings.each { |key, val| val.map!(&:downcase) } }
  before_create :create_session_token
  
  after_create :set_admin_to_false
  
  serialize :job_settings, Hash
  serialize :company_settings, Hash
  serialize :job_prefs, Hash
    
  after_initialize :initialize_settings
  store_accessor :job_filters, :keywords, :dept, :sub_dept, :experience
  
  belongs_to(
    :employer,
    class_name: 'Company',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  belongs_to(
    :vc_employer,
    class_name: 'Investor', 
    foreign_key: :investor_company_id,
    primary_key: :id
  )
  
  has_many(
    :user_jobs,
    class_name: 'UserJob',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :jobs_applied,
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
    :object_skills,
    class_name: 'ObjectSkill',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :tech_stack,
    through: :object_skills,
    source: :skill
  )  
  
  has_many(
    :user_articles,
    class_name: 'UserArticle',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_many(
    :articles,
    through: :user_articles,
    source: :article
  )
  
  has_attached_file :avatar, styles: { medium: '300x200>', thumb: '100x100>' },
    default_url: '/images/:style/missing.png'

  has_attached_file :snapshots, styles: { original: '200x400', medium: '300x300', large: '300x500' },
    path: ":rails_root/public/system/:class/:attachment/:id_partition/:style/:normalized_userpic_file_name.:extension",
    url: "/system/:class/:attachment/:id_partition/:style/:normalized_userpic_file_name.:extension"
  
  Paperclip.interpolates :normalized_userpic_file_name do |attachment, style|
    attachment.instance.normalized_userpic_file_name
  end

  def store_article_id_temporarily(article_id)
    @article_id = article_id
  end
  
  def normalized_userpic_file_name
    "id-#{self.id}-name-#{self.fname.squish}-articleid-#{self.article_id}"
  end
  
      
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

  # Autocomplete ------------------------------------------------------------------
  def user_company=(id)
    self.company_id = id
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
  
  # Twitter ----------------------------------------------------------------------
  def tweet(tweet)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key     = ENV['TWITTER_KEY']
      config.consumer_secret  = ENV['TWITTER_SECRET']
      config.access_token     = self.identities.where(provider: 'twitter').first.oauth_token
      config.access_token_secret    = self.identities.where(provider: 'twitter').first.oauth_secret
    end
    
    client.update(tweet)
  end  

  # LinkedIn ----------------------------------------------------------------------  

  def linkedin_client
    client = OAuth2::Client.new(
      ENV['LINKEDIN_KEY'],
      ENV['LINKEDIN_SECRET'],
      :authorize_url => "/uas/oauth2/authorization?response_type=code", #LinkedIn's authorization path
      :token_url => "/uas/oauth2/accessToken", #LinkedIn's access token path
      :site => "https://www.linkedin.com"
    )
  end
    
  # Private------------------------------------------------------------------------
  private
  
    def create_session_token
      self.session_token = SecureRandom.urlsafe_base64
    end
  
     def initialize_settings
       self.job_settings ||= '{}'
       self.company_settings ||= '{}'
       self.job_prefs ||= '{}'
    end
    
    def set_admin_to_false
      self.is_admin = false
      self.save
    end
  
end
