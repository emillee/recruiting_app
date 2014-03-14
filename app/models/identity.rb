class Identity < ActiveRecord::Base
  
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  validates :user_id, presence: true
  
  def self.find_with_omniauth(auth)
    find_by provider: auth['provider'], uid: auth['uid']
  end
  
  def self.initialize_from_omniauth(auth)
    @identity = new(
      uid: auth.uid, 
      provider: auth.provider,
      oauth_token: auth.credentials.token
    )
    
    if auth.credentials.expires_at
      @identity.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
    
    return @identity
  end
  
end