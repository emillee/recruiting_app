class CompaniesController < ApplicationController

  respond_to :html, :json, :js

  # RESTful Routes ---------------------------------------------------------------------------
  def index
    set_tab('companies')
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
    set_tab('companies')    
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
    set_tab('companies') 
    @company = Company.find(params[:id])
    @job = @company.job_listings.build
  end
  
  def update
    @company = Company.find(params[:id])
    article_id = params[:company][:article_id]
    @company.store_article_id_temporarily(article_id)
    
    if @company.update_attributes(company_params)
      respond_with @company
    end
  end
  
  def destroy
    @company.find(params[:id]).destroy
  end
  
  # Non-RESTful Routes ---------------------------------------------------------------------------
  def add_section
    @company = Company.find(params[:id])
    new_section = params['company']['career_sections']
    @company.career_sections = @company.career_sections.merge({ new_section => '' })
    @company.save
    redirect_to company_url(@company)
  end
  
  def delete_snapshot
    @company = Company.find(params[:id])
    article = Article.find(params[:article_id])
    article_id = article.id
    
    size_arr = %w(large medium original)
    full_path = "#{Rails.root}/" + "public" + params[:path]
    
    if article.body.include?(params[:path])
      remove_img_section = article.body.scan(/<div class="article-#{article_id}.*end-of-image-div -->/m)[0]
      body = article.body
      body.slice!(remove_img_section)
      article.update_columns(body: body)
    end

    current_size = nil    
    size_arr.each do |size|
      current_size = size if full_path.include?(size)
    end
    
    size_arr.each do |size|
      this_path = full_path.gsub(current_size, size)
      File.delete(this_path) 
    end
    
    redirect_to company_url(@company)
  end
  
  #------------------------------------------------------------------------------
	private
	
  	def company_params
      params.require(:company).permit(:name, :total_money_raised, :num_employees, :career_page_link, :overview, :year_founded,
        :neighborhood, :category_code, :city, :snapshots, :logo, { career_sections: ['Keys Here'] })
  	end
  		
end



















