class Admin::JobsController < Admin::ApplicationController

	def index
    @jobs = []
    jobs = Job.all.sample(10)

    jobs.each do |job|
      @job_ranker = JobRanker.new(job, current_user)
      @jobs << @job_ranker.job
    end

    @jobs.sort! { |a,b| b.job_score <=> a.job_score }  
   end

  def send_listings_form
    @recipient = User.find(77)

		if current_user.job_settings.any? && current_user.job_settings[:key_skills] 
	  	@jobs = Job.return_jobs_with_key_skills(current_user).limit(20)
	  elsif current_user.job_settings.any?
	    @jobs = Job.return_jobs_without_key_skills(current_user).limit(20)
	  else
	    @jobs = Job.all.limit(20)
	  end
  end

  def send_listings
    greeting = params[:greeting]
    first_paragraph = params[:first_paragraph]
    third_paragraph = params[:third_paragraph]
    jobs = params[:job][:ids].map { |id| Job.find(id) }

    if JobMailer.send_listings(
        greeting,
        jobs
      ).deliver
    end
  end

  # def forward_job 
  #   job = Job.find(params[:job_id])
  #   sender_email = params[:email_info][:sender_email]
  #   recipient_email = params[:email_info][:recipient_email]
  #   subject_line = "You received a forward from #{sender_email}: #{job.title.titleize}"
  #   email_body = params[:email_info][:body]
    
  #   if JobMailer.forward_job(
  #     recipient_email,
  #     subject_line,
  #     email_body,
  #     job,
  #     sender_email
  #     ).deliver
  #     flash[:notice] = "Forwarded successfully"
  #   else
  #     flash[:notice] = "Please try again"
  #   end
    
  #   redirect_to jobs_url
  # end  
   
end