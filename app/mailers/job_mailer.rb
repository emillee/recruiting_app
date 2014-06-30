class JobMailer < ActionMailer::Base
  
  include SendGrid
  default from: 'contact@wolfpackbeta.com'
  default template_path: 'mailers'

  def forward_job(recipient_email, subject_line, email_body, job, email_sender)
    @recipient_email = recipient_email
    @subject_line = subject_line
    @email_body = email_body
    @job = job
    @email_sender = email_sender
    
    mail(
      to: @recipient_email, 
      from: @email_sender, 
      subject: @subject_line, 
      email_body: @email_body
    )
  end

  def send_listings(greeting, jobs)
    @greeting = greeting
    @jobs = jobs

    mail(
      to: 'from',
      from: 'to',
      subject: 'blah'
    )
  end
  
end