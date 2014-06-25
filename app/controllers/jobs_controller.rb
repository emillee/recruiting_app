class JobsController < ApplicationController
  
  respond_to    :html, :json
  before_filter :set_this_tab, only: [:index, :show]
  before_filter :redirect_if_applicant

  # RESTful Routes ---------------------------------------------------------------------------
  def index
    @page = params[:page]

    if params[:filter]
      @jobs = filtered_jobs(params[:filter])
    elsif current_user.job_settings.any? && current_user.job_settings[:key_skills] 
      @jobs = Job.return_jobs_with_key_skills(current_user).page(params[:page]).per(10) 
    elsif current_user.job_settings.any?
      @jobs = Job.return_jobs_without_key_skills(current_user).page(params[:page]).per(10)
    else
      @jobs = Job.all.page(params[:page]).per(10)
      respond_to do |format|
        format.html
        format.csv { render text: @jobs.to_csv }
      end      
    end

    # @jobs = Job.rank_jobs(jobs, current_user)
    # @jobs.sort! { |a,b| b.job_score <=> a.job_score }
    # @jobs = Kaminari.paginate_array(@jobs).page(params[:page]).per(10)    
  end
  
  def new
    @job = Job.create!
    @user = current_user
  end

  def edit
    @job = Job.find(params[:id])
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit_company
    @job = Job.find(params[:id])
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
    end

    redirect_to edit_job_url(@job)
  end
  
  def destroy
    @job = Job.find(params[:id])
    @company = @job.listing_company
    @job.destroy
    redirect_to company_url(@company)
  end
  
  # NON RESTFUL ---------------------------------------------------------------------------
  def wolfpack_option
    @job = Job.find(params[:id])
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
    job = Job.find(params[:job_id])
    sender_email = params[:email_info][:sender_email]
    recipient_email = params[:email_info][:recipient_email]
    subject_line = "You received a forward from #{sender_email}: #{job.title.titleize}"
    email_body = params[:email_info][:body]
    
    if JobMailer.forward_job(
      recipient_email,
      subject_line,
      email_body,
      job,
      sender_email
      ).deliver
      flash[:notice] = "Forwarded successfully"
    else
      flash[:notice] = "Please try again"
    end
    
    redirect_to jobs_url
  end
  
	#---------------------------------------------------------------------------------------
	private

  def job_params
    params.require(:job).permit(:link, :title, :full_text, :is_draft, :technical_problem_commentary,
      :company_id, :dept, :sub_dept, :years_exp, :description, key_phrases: [], req_skills: [])
  end  

  def redirect_if_applicant
    if current_user.is_applicant
      redirect_to pending_applicant_url
    end
  end

  def filtered_jobs(filter)
    @filter = filter
    case filter
    when 'applied'
      return current_user.jobs_applied.page(params[:page]).per(10).order('years_exp DESC')
    when 'interested'
      return current_user.saved_jobs.page(params[:page]).per(10).order('years_exp DESC')
    when 'removed'
      return current_user.removed_jobs.page(params[:page]).per(10).order('years_exp DESC')
    else
      return Job.all.page(params[:page]).per(10).order('years_exp DESC')
    end
  end

  def job_preapproved?(job)
    if current_user
      current_user.preapproved_jobs.include?(job)
    else
      return false
    end
  end

  def set_this_tab
    set_tab('jobs')  
  end
  
end

