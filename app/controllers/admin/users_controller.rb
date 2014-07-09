class Admin::UsersController < UsersController 

	def index
	end

	def edit
		@user = User.find(params[:id])

		if @user.job_settings.any? && @user.job_settings[:key_skills] 
	  	@jobs = Job.return_jobs_with_key_skills(@user).limit(20)
	  elsif @user.job_settings.any?
	    @jobs = Job.return_jobs_without_key_skills(@user).limit(20)
	  else
	    @jobs = Job.all.limit(20)
	  end
	end

	def update
		super
		redirect_to edit_admin_user_url(@user)
	end

end