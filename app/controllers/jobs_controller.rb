class JobsController < ApplicationController
  
  respond_to :html, :json
  before_filter :set_this_tab, only: [:index, :show]

  # RESTful Routes ---------------------------------------------------------------------------
  
  def index
    @jobs = Job.all.joins(:user_jobs)

    if params[:filter] && current_user
      @filter = params[:filter]
      case params[:filter]
      when 'applied'
        @jobs = current_user.jobs_applied.page(params[:page]).per(10).order('years_exp DESC')
      when 'interested'
        @jobs = current_user.saved_jobs.page(params[:page]).per(10).order('years_exp DESC')
      when 'removed'
        @jobs = current_user.removed_jobs.page(params[:page]).per(10).order('years_exp DESC')
      else
        @jobs = Job.all.page(params[:page]).per(10).order('years_exp DESC')
      end
    elsif current_user && !current_user.job_settings.blank?
      @jobs = Job.filter(current_user.job_settings.slice(:dept, :sub_dept, :years_exp, :keywords)).page(params[:page]).per(10).order('years_exp DESC')
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
      @job.import_data
      redirect_to company_url(@company)
    else
      flash[:error] = "Please try again"
      render :new
    end
  end
  
  def show      
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
    sender_email = params[:email_info][:sender_email]
    recipient_email = params[:email_info][:recipient_email]
    email_subject = params[:email_info][:subject]
    job = Job.find(params[:job_id])
    
    if JobMailer.forward_job(
      recipient_email,
      email_subject,
      job,
      sender_email
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

    def set_this_tab
      set_tab('jobs')  
    end
  
end

