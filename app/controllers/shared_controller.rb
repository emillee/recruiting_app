class SharedController < ApplicationController

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

end