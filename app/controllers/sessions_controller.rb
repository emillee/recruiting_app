class SessionsController < ApplicationController
  
  def new
    render :new
  end
  
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    
    if user && user.password_match?(params[:session][:password])
      sign_in(user)
      flash[:coming_soon] = 'You are now logged into NyTech.io'
      redirect_back_or(root_url)
    else
      flash.now[:error] = 'Invalid login credentials. Please try again.'
      render :new
    end
  end
  
  def destroy
    sign_out
    redirect_to(root_url)
  end

end
