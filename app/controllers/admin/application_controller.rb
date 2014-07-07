class Admin::ApplicationController < ApplicationController
  before_filter :require_admin_user
  
  def require_admin_user
    # require_sign_in if current_user.nil?
    
    unless (current_user && current_user.is_admin) 
      flash[:notice] = "Sorry, you must be an admin to do that"
      redirect_back_or :root
    end
  end
  
end