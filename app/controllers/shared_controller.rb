class SharedController < ApplicationController

  def welcome_to_wolfpack
    @applicant = current_user
  end

	def contact_us
	end

  def send_contact_us_email
  	sender_email = params[:email_info][:sender_email]
  	recipient_email = params[:email_info][:recipient_email]
  	subject_line = 'Message from Wolfpack Beta user'
  	email_body = params[:email_info][:email_body]

  	SharedMailer.contact_us(
  		sender_email,
  		recipient_email,
  		subject_line,
  		email_body
  	).deliver

    redirect_to :back
  end	

  def all_activity
    if current_user.job_settings.any? && current_user.job_settings[:key_skills] 
      @jobs = Job.return_jobs_with_key_skills(current_user).page(params[:page]).per(10) 
    elsif current_user.job_settings.any?
      @jobs = Job.return_jobs_without_key_skills(current_user).page(params[:page]).per(10)
    else
      @jobs = Job.all.page(params[:page]).per(10)
    end

    @articles = Article.all
    @users = User.all
  end

end