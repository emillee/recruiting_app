class Identity < ActiveRecord::Base
  
  belongs_to :user
    
  validates :user_id, presence: true
  
  def self.find_with_omniauth(auth)   
    find_by provider: auth['provider'], uid: auth['uid']
  end
  
  def self.initialize_from_omniauth(auth)
    @identity = new(
      uid: auth.uid, 
      provider: auth.provider,
      oauth_token: auth.credentials.token,
      oauth_secret: auth.credentials.secret
    )
    
    if auth.credentials.expires_at
      @identity.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
    
    if @identity.oauth_secret.nil?
      @identity.oauth_secret = auth.credentials.oauth_token_secret
    end
    
    return @identity
  end
  
end