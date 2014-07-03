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

  def send_listings(sender, recipient, subject, greeting, first_paragraph, second_paragraph, jobs, closing_paragraph)
    @greeting = greeting
    @first_paragraph = first_paragraph
    @second_paragraph = second_paragraph
    @jobs = jobs
    @closing_paragraph = closing_paragraph 
    
    mail(
      to: recipient,
      from: sender,
      subject: subject
    )
  end
  
end