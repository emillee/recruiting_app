class CompaniesController < ApplicationController
  
  respond_to :html, :json
  
  def show
    @company = Company.find(params[:id])
    @job = @company.job_listings.build
  end
  
  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to company_url
    end
  end
  
  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      respond_with @company
    end
  end
  

  def destroy
    @company.find(params[:id]).destroy
  end

  def index
    @job = Job.new
    
    # if current_user && !current_user.job_settings.blank?
    #   @companies = Company.search(current_user.job_settings)
    # else
      @companies = Company.all.limit(200).order(:name)
    # end
  end
  
  #------------------------------------------------------------------------------
	private
	
  	def company_params
  		params.require(:company).permit(:name, :total_money_raised, :num_employees, :career_page_link)
  	end
	
end




















