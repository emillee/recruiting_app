class CompaniesController < ApplicationController

  before_filter :set_this_tab, only: [:index, :new]
  respond_to :html, :json, :js

  # RESTful Routes ---------------------------------------------------------------------------
  def index
    @job = Job.new
    @keywords = params[:company_search][:keywords] if params[:company_search]
    @all_scopes = %w(is_hiring page_available page_unavailable page_blank)
    params[:company_search] ||= {}
    
    if params[:company_search].empty?
      # params[:company_search]['is_hiring'] = ['is_hiring']
       @scopes_checked = params[:company_search]
    else 
      @scopes_checked = params[:company_search]
    end
      
    if params[:company_search]
      @companies = Company.filter(params[:company_search].slice(:keywords, :page_available, :page_unavailable, :page_blank, :is_hiring)).page(params[:page]).per(10)
    else
      @companies = Company.all.page(params[:page]).per(10)
    end
    
    # For autocomplete
    if params[:q]
      @companies = Company.where("name ilike ?", "%#{params[:q]}%")
    end
    
    respond_to do |format|
      format.html
      format.json { render json: @companies.map(&:attributes) }
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

    if params[:next]
      @company = @company.next
    elsif params[:prev]
      @company = @company.prev
    else
      @company = Company.find(params[:id])
    end
    
    @job = @company.job_listings.build
    @skill = Skill.new
  end
  
  def update
    @company = Company.find(params[:id])
    if params[:company] && params[:company][:article_id]
      article_id = params[:company][:article_id] 
      @company.store_article_id_temporarily(article_id)
    end
    
    # ASK BACKNOL, THROWS TOO MANY REDIRECTS ERROR
    if @company.update_attributes(company_params)
      respond_with @company
    end
  end
  
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to company_url(@company.next)
  end
  
  # Non-RESTful Routes -------------------------------------------------------------------
  def add_section
    @company = Company.find(params[:id])
    new_section = params['company']['career_sections']
    @company.career_sections = @company.career_sections.merge({ new_section => '' })
    @company.save
    redirect_to company_url(@company)
  end
  
  #---------------------------------------------------------------------------------------
	private
	
	def company_params
    params.require(:company).permit(:name, :total_money_raised, :num_employees, :career_page_link, :overview, :year_founded,
      :blog_link, :neighborhood, :category_code, :city, :snapshots, :logo, { career_sections: ['Keys Here'] },
      :the_big_idea_soundbite, :the_big_idea_commentary, :scale_soundbite, :scale_commentary,
      :team_soundbite, :team_commentary, :culture_soundbite, :culture_commentary, :wolfpack_commentary)
	end

  def set_this_tab
    set_tab('companies')
  end
  		
end



















