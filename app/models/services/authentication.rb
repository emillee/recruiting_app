class Authentication

	def initialize(params, oauth_hash=nil)
		@params = params
		@oauth_hash = oauth_hash
	end


	def user_from_landing_page_linkedin_callback(user)
    user.update_column('email', @oauth_hash.info.email)
    user.update_column('linkedin_url', @oauth_hash.info.urls['public_profile'].squish)
    user
	end

  def user_from_email_and_pw
  	email = @params[:session][:email]
  	password = @params[:session][:password]
    
    user = User.find_by_email(email)
    return user if user && user.password_match?(password)
  end

  def user_from_omniauth(current_user)
    @identity = Identity.find_with_omniauth(@oauth_hash)
    
    if @identity.nil? 
      p "------ IN HERE"
    	@identity = Identity.initialize_from_omniauth(@oauth_hash)
    	@identity.user = current_user
    	@identity.save
    	return @identity.user
    else
    # elsif current_user.is_member
      p "------ IN HERE"
    	return @identity.user if @identity.user.present?
    end
  end	


  def inputs_from_omniauth(current_user)
    current_user.fname = @oauth_hash.info.name.split(' ')[0] if auth.info.name
    current_user.lname = @oauth_hash.info.name.split(' ')[1] if auth.info.name
    current_user.email = @oauth_hash.info.email if @oauth_hash.info.email
    current_user.save
    current_user
  end

end