class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  include SessionsHelper
  include ImagesHelper
  
	def set_tab(tab)
    @tab = tab
  end
  
end

