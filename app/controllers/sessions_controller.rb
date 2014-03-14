class SessionsController < ApplicationController
  
  def new
    render :new
  end
  
  
  def create
    auth = request.env['omniauth.auth']
    
    # if the session create is coming from social
    if auth
      @identity = Identity.find_with_omniauth(auth) if auth
      @identity = Identity.initialize_from_omniauth(auth) if @identity.nil?
    
      if signed_in?
        if @identity.user == current_user
          @identity.save!
          redirect_to root_url, notice: 'Already linked that account'
        else
          # links a new social 
          @identity.user = current_user
          @identity.save!
          redirect_to root_url
        end
      else
        if @identity.user.present?
          sign_in(@identity.user)
          redirect_to root_url, notice: 'Signed in!'
        else
          @user = User.new_guest
          @user = @user.inputs_from_omniauth(auth)
          @identity.user_id = @user.id
          @identity.save!
          sign_in(@user)
          redirect_to root_url
        end
      end
    # request is not coming from social (but from email/pw fields)
    else
      user = User.find_by_email(params[:session][:email].downcase)    
      
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
