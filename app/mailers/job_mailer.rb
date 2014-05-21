class JobMailer < ActionMailer::Base
  
  include SendGrid
  
  default from: 'default@default.com'
  
  def forward_job(recipient_email, subject_line, email_body, job, email_sender)
    @recipient_email = recipient_email
    @subject_line = subject_line
    @email_body = email_body
    @job = job
    @email_sender = email_sender
    
    mail(to: @recipient_email, from: @email_sender, subject: @subject_line, email_body: @email_body)
  end
  
end