class JobsController < ApplicationController
  
  respond_to :html, :json
  
  def root_action
    redirect_to jobs_url
  end
  
  def new
    @job = Job.new
  end
  
  def create
    @company = Company.find(params[:company_id])
    @job = @company.job_listings.new(job_params)
    @job_scraper = JobScraper.new(@job)
    @job_scraper.input_job_data
    
    if @job.save
      flash[:success] = "Job saved successfully"
      redirect_to company_url(@company)
    else
      flash[:error] = "Please try again"
      render :new
    end
  end
  
  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      flash[:success] = "Job updated"
      @company = @job.listing_company
      respond_with @company
    end
  end
  
  def show 
    @job = Job.find(params[:id])
  end
  
  def index
    if current_user && !current_user.job_settings.blank?
      @jobs = Job.search(current_user.job_settings)
    else
      @jobs = Job.all
    end
  end
  
  def destroy
    @job = Job.find(params[:id])
    @company = @job.listing_company
    @job.destroy
    redirect_to company_url(@company)
  end
  
  def filters
  end
  
  # NON RESTFUL-------------------------------------------------------------
  def import
    Job.import(params[:file])
    redirect_to jobs_url, notice: "Jobs imported"
  end
  
	#-------------------------------------------------------------------------
	private

  	def job_params
  		params.require(:job).permit(:link, :title, :full_text, :is_draft,
  		  :company_id, :dept, :sub_dept, :years_exp, :key_skill_one, :key_skill_two,
  		  :description)
  	end
  
end




