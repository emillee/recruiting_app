class JobsController < ApplicationController
  
  respond_to :html, :json

  # RESTful Routes ---------------------------------------------------------------------------
  
  def index
    set_tab('jobs')        
    if current_user && !current_user.job_settings.blank?
      @jobs = Job.filter(current_user.job_settings.slice(:dept, :sub_dept, :years_exp, :keywords)).page(params[:page]).per(10).order('years_exp DESC')
      @filter = params[:filter]
    else
      @jobs = Job.all.page(params[:page]).per(10)
      respond_to do |format|
        format.html
        format.csv { render text: @jobs.to_csv }
      end      
    end
  end
  
  def new
    @job = Job.new
  end
  
  def create
    @company = Company.find(params[:company_id])
    @job = @company.job_listings.new(job_params)
    
    if @job.save
      redirect_to company_url(@company)
    else
      flash[:error] = "Please try again"
      render :new
    end
  end
  
  def show 
    set_tab('jobs')      
    @job = Job.find(params[:id])
  end
   
  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      flash[:success] = "Job updated"
      @company = @job.listing_company
      redirect_to companies_url
    end
  end
  
  def destroy
    @job = Job.find(params[:id])
    @company = @job.listing_company
    @job.destroy
    redirect_to company_url(@company)
  end
  
  # NON RESTFUL ---------------------------------------------------------------------------
  
  # For config/routes root to:
  def root_action
    redirect_to jobs_url
  end
  
  def import_data
    @job = Job.find(params[:id])
    @job.import_data
    redirect_to company_url(@job.listing_company)
  end
  
  def forward_form
    @job = Job.find(params[:id])
  end

  def forward_job 
    recipient_email = params[:email_info][:email]
    email_subject = params[:email_info][:subject]
    job = Job.find(params[:job_id])
    email_sender = current_user
    
    if JobMailer.forward_job(
      recipient_email,
      email_subject,
      job,
      email_sender
      ).deliver
      flash[:notice] = "Forwarded successfully"
    else
      flash[:notice] = "Please try again"
    end
    
    redirect_to jobs_url
  end
  
  def flip_view
    set_tab('jobs')      
    if current_user && !current_user.job_settings.blank?
      @jobs = Job.filter(current_user.job_settings.slice(:dept, :sub_dept, :years_exp, :keywords)).page(params[:page]).per(15).order('years_exp DESC')
      @preapproved_jobs = @jobs.select { |job| job_preapproved?(job) }
    else
      @jobs = Job.all.page(params[:page]).per(15)
      @preapproved_jobs = @jobs.select { |job| job_preapproved?(job) }
    end
  end
  
	# PRIVATE ---------------------------------------------------------------------------
	private
	
	  def job_preapproved?(job)
	    if current_user
	      current_user.preapproved_jobs.include?(job)
      else
        return false
      end
    end

  	def job_params
  		params.require(:job).permit(:link, :title, :full_text, :is_draft,
  		  :company_id, :dept, :sub_dept, :years_exp, :description, key_phrases: [], req_skills: [])
  	end
  
end

