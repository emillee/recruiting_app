class SessionsController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash
      if request.env['omniauth.params']['origin'] = 'landing_page'
        @applicant = current_user
        @applicant.update_column('email', auth_hash.info.email)
        @applicant.update_column('linkedin_url', auth_hash.info.urls['public_profile'])
        redirect_to welcome_to_wolfpack_url
      else
        handle_omniauth_request(request.env['omniauth.auth'])
      end
    else
      handle_email_password_login(params[:session][:email].downcase, params[:session][:password])
    end      
  end
  
  def destroy
    sign_out
    redirect_to(root_url)
  end

  #---------------------------------------------------------------------------------------
  private

  def handle_email_password_login(email, password)
    user = User.find_by_email(email)

    if user && user.password_match?(password)
      sign_in(user)
      flash[:welcome] = ""
      redirect_to root_url
    else
      p '--------in here------'
      flash[:error] = 'Invalid login credentials. Please try again.'
      render :new
    end
  end

  def handle_omniauth_request(auth)
    @identity = Identity.find_with_omniauth(auth)

    if @identity && @identity.user.present?
      sign_in(@identity.user)
      redirect_to root_url, notice: 'Signed in!'
    else
      flash[:error] = 'Invalid login credentials. Please try again.'
      render :new
    end
  end

end
