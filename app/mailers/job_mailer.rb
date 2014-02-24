class JobMailer < ActionMailer::Base
  
  include SendGrid
  
  default from: 'default@default.com'
  
  def forward_job(recipient_email, email_subject, job, email_sender)
    @recipient_email = recipient_email
    @email_subject = email_subject
    @job = job
    @email_sender = email_sender
    
    mail(to: @recipient_email, from: email_sender.email, subject: @email_subject)
  end
  
end