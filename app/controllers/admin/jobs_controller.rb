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

  def preapproval_applicants
    @preapprovals = UserJobPreapproval.all.where_user_is_applicant
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
    first_name = params[:first_name]
    sender = params[:sender]
    recipient = params[:recipient]
    greeting = params[:greeting]
    first_paragraph = params[:first_paragraph]
    second_paragraph = params[:second_paragraph]
    closing_paragraph = params[:closing_paragraph]

    jobs = params[:job][:ids].map { |id| Job.find(id) }
    subject = "#{first_name}: Out of 1,000+ Listings in our 
      Database, here's #{jobs.size} We Picked For You"
    subject = subject.titleize

    if JobMailer.send_listings(
        sender,
        recipient,
        subject,
        greeting,
        first_paragraph,
        second_paragraph,
        jobs,
        closing_paragraph
      ).deliver
    end
  end 
   
end