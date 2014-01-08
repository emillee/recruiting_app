class User < ActiveRecord::Base
  
  attr_reader :password # for password length validation
  
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, presence: true
  
  before_save { self.email = self.email.downcase }
  before_save :create_session_token
  
  
  # Sessions / Authentication------------------------------------------
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
  
  # Private----------------------------------------------------------
  private
  def create_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end
  
end
