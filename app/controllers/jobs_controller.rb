class JobsController < ApplicationController
  
  respond_to :html, :json

  # RESTful Routes ---------------------------------------------------------------------------
  
  def index
    if current_user && !current_user.job_settings.blank?
      @jobs = Job.search(current_user.job_settings).page(params[:page]).per(10)
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
      redirect_to companies_url
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
    redirect_to companies_url
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
  
  def flipboard
    if current_user && !current_user.job_settings.blank?
      @jobs = Job.search(current_user.job_settings).page(params[:page]).per(11)
    else
      @jobs = Job.all.page(params[:page]).per(11)
      respond_to do |format|
        format.html
        format.csv { render text: @jobs.to_csv }
      end      
    end
  end
  
  
	# PRIVATE ---------------------------------------------------------------------------
	private

  	def job_params
  		params.require(:job).permit(:link, :title, :full_text, :is_draft,
  		  :company_id, :dept, :sub_dept, :years_exp, :description, key_phrases: [], req_skills: [])
  	end
  
end

  # ARCHIVE ---------------------------------------------------------------------------
  # 
  # def update_key_skills
  #   @job = Job.find(params[:id])
  #   @company = @job.listing_company
  # 
  #   params[:job][:key_skills].split(';').each do |key_skill|
  #     @job.key_skills += [key_skill]
  #   end
  # 
  #   @job.save    
  #   render company_url(@company)
  # end
  # 
  # def import
  #   Job.import(params[:file])
  #   redirect_to jobs_url, notice: "Jobs imported"
  # end

