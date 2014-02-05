class CompaniesController < ApplicationController
  
  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to company_url
    end
  end

  def destroy
    @company.find(params[:id]).destroy
  end

  def index
    @job = Job.new
    
    if current_user && !current_user.job_settings.blank?
      @companies = Company.search(current_user.job_settings)
    else
      @companies = Company.all.limit(20)
    end
  end
  
  
  #------------------------------------------------------------------------------
	private
	
  	def company_params
  		params.require(:company).permit(:name, :total_money_raised, :num_employees)
  	end
	
end
