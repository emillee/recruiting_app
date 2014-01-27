class JobsController < ApplicationController
  
  def root_action
    redirect_to jobs_url
  end
  
  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new(job_params)
    
    if @job.save
      flash[:success] = "Job saved successfully"
      redirect_to(@job)
    else
      flash[:error] = "Please try again"
      render :new
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
    
    @search = Search.new
  end
  
  # NON RESTFUL-------------------------------------------------------------
  def import
    Job.import(params[:file])
    redirect_to jobs_url, notice: "Jobs imported"
  end
  
	#-------------------------------------------------------------------------
	private

  	def job_params
  		params.require(:job).permit(:title_specific, :category,:experience_required,
  		  :company, :description, :link, :is_draft, :company_id)
  	end
  
end


