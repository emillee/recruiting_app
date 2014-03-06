class CompaniesController < ApplicationController

  respond_to :html, :json

  # RESTful Routes ---------------------------------------------------------------------------

  def index
    @job = Job.new
    @keywords = params[:company_search][:keywords] if params[:company_search]
    @all_scopes = %w(page_available page_unavailable page_blank)
    @scopes_checked = params[:company_search]
      
    if params[:company_search]
      @companies = Company.filter(params[:company_search].slice(:keywords, :page_available, :page_unavailable, :page_blank)).page(params[:page]).per(10)
    else
      @companies = Company.all.page(params[:page]).per(10)
    end
  end

  # @keywords = params[:company_search][:keywords] if params[:company_search][:keywords]
  # @scopes = params[:company_search][:scopes] if params[:company_search][:scopes]
  # 
  # if !@keywords.empty? && !@keywords.nil?
  #   @companies = @companies.keyword_search(@keywords)
  # end
  # 
  # if !@scopes.nil? && !@scopes.empty?  
  #   @scopes.each do |scope|
  #     @companies = @companies.send(scope)
  #   end
  # end
  
  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to company_url
    end
  end
  
  
  def show
    @company = Company.find(params[:id])
    @job = @company.job_listings.build
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


  
  #------------------------------------------------------------------------------
	private
	
  	def company_params
  		params.require(:company).permit(:name, :total_money_raised, :num_employees, :career_page_link, :overview, :year_founded)
  	end
	
end




















