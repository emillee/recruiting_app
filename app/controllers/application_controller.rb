class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :require_current_user_or_guest
  
  include SessionsHelper
  include ImagesHelper
  
	def set_tab(tab)
    @tab = tab
  end

  def require_current_user_or_guest
  	user = current_user || User.new_guest
  	sign_in(user)
  end
  
end

