class CompaniesController < ApplicationController

  respond_to :html, :json, :js

  # RESTful Routes ---------------------------------------------------------------------------

  def index
    @job = Job.new
    @keywords = params[:company_search][:keywords] if params[:company_search]
    @all_scopes = %w(is_hiring page_available page_unavailable page_blank)
    params[:company_search] ||= {}
    
    if params[:company_search].empty?
      params[:company_search]['is_hiring'] = ['is_hiring']
       @scopes_checked = params[:company_search]
    else 
      @scopes_checked = params[:company_search]
    end
      
    if params[:company_search]
      @companies = Company.filter(params[:company_search].slice(:keywords, :page_available, :page_unavailable, :page_blank, :is_hiring)).page(params[:page]).per(10)
    else
      @companies = Company.all.page(params[:page]).per(10)
    end
  end
  
  def new
    @company = Company.new
    @job = Job.new
  end
  
  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to company_url(@company)
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
  		params.require(:company).permit(:name, :total_money_raised, :num_employees, :career_page_link, :overview, :year_founded,
  		  :neighborhood, :category_code, :city)
  	end
	
end




















