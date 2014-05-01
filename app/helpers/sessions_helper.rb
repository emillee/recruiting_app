module SessionsHelper

	def require_membership
		unless (current_user.is_member || current_user.is_admin)
			store_location
			redirect_to login_url
		end
	end	

	def sign_in(user)
		session[:session_token] = user.session_token
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_session_token(session[:session_token])
	end

	def current_user?(user)
		user == current_user
	end

	def require_sign_in
		unless signed_in?
			store_location
			redirect_to login_url
		end
	end

	def sign_out
		self.current_user = nil
		session[:session_token] = nil
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url 
	end

end