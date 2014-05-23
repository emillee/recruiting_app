class SharedMailer < ActionMailer::Base

	include SendGrid
	default from: 'contact@wolfpackbeta.com'
	default template_path: 'mailers'

	def contact_us(sender, recipient, subject_line, body)
		@sender_email = sender
		@recipient_email = recipient
		@subject_line = subject_line
		@email_body = body

		mail(to: @recipient_email, from: @sender_email, subject: @subject_line, email_body: @email_body)
	end


end