class SessionsController < ApplicationController
  
  def new
    @user = User.new
    render :new
  end
  
  def create
    if request.env['omniauth.auth']
      handle_omniauth_request(request.env['omniauth.auth'])
    else
      handle_email_password_login(User.find_by_email(params[:session][:email].downcase))
    end      
  end
  
  def destroy
    sign_out
    redirect_to(root_url)
  end

  #---------------------------------------------------------------------------------------
  private

  def handle_email_password_login(user)
    if user && user.password_match?(params[:session][:password])
      sign_in(user)
      flash[:welcome] = ""
      redirect_back_or(root_url)
    else
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
