class SessionsController < ApplicationController
  
  def new
    render :new
  end
  
  
  def create
    if !env['omniauth.auth'].nil?
      user = User.from_omniauth(env['omniauth.auth'])
      sign_in(user)
      redirect_to root_url
    elsif user = User.find_by_email(params[:session][:email].downcase)    
      if user && user.password_match?(params[:session][:password])
        sign_in(user)
        flash[:welcome] = ""
        redirect_back_or(root_url)
      else
        flash.now[:error] = 'Invalid login credentials. Please try again.'
        render :new
      end
    end
  end
  
  
  def destroy
    sign_out
    redirect_to(root_url)
  end


end
