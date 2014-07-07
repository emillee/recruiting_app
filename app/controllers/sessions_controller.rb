class SessionsController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    req_origin = request.env['omniauth.params']['origin'] if request.env['omniauth.params']
    oauth_hash = request.env['omniauth.auth']
    auth = Authentication.new(params, oauth_hash)

    # from landing page only
    if req_origin && req_origin == 'landing_page'
      user = auth.user_from_landing_page_linkedin_callback(current_user)
      if user.is_applicant
        redirect_to welcome_to_wolfpack_url
      elsif user.is_member
        redirect_to root_url
      end

    # all other login requests
    else
      user = oauth_hash ? auth.user_from_omniauth(current_user) : auth.user_from_email_and_pw
  
      if user
        sign_in(user)
        flash[:welcome] = ""
        redirect_to root_url      
      else    
        flash[:error] = 'Invalid login credentials. Please try again.'
        render :new         
      end 
    end
  end
  
  def destroy
    sign_out
    redirect_to(root_url)
  end


end
