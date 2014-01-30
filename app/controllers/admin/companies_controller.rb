# class Admin::CompaniesController < Admin::ApplicationController
#   
#   def new
#     
#   end
#   
#   def index
#     if current_user && !current_user.job_settings.blank?
#       @companies = Company.search(current_user.job_settings)
#     else
#       @companies = Company.all.limit(20)
#     end
#   end
#   
# end