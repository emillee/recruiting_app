class UsersController < ApplicationController
  
  respond_to :js
    
  # RESTful Routes ---------------------------------------------------------------------------
  
	def index
    set_tab('users')  	  
		@users = User.all
	end
	
	def new
    set_tab('users')  	  	  
		@user = User.new
	end

  def edit
    set_tab('users')  	      
    @user = User.find(params[:id])
  end

	def create
		@user = params[:user] ? User.new(user_params) : User.new_guest
		if @user.save
			sign_in(@user)
			flash[:success] = "Welcome to NYTech.io!"
			redirect_to(@user)
		else
		  flash[:notice] = "didn't work"
			render :new
		end
	end

	def show
    set_tab('users')  	  	  
		@user = User.find(params[:id])
		@tab ||= "Recent"
	end

	def update
    @user = User.find(params[:id])
    
    if params[:user]
      keywords_arr = params[:user][:job_settings][:keywords] unless params[:user][:job_settings].nil?

      without_blanks = []
    
      if keywords_arr
        keywords_arr.each do |keyword|
          without_blanks << keyword unless keyword == ""
        end
      end
    
      if without_blanks.empty?
        params[:user][:job_settings].delete(:keywords) unless params[:user][:job_settings].nil? 
      else
        params[:user][:job_settings][:keywords] = without_blanks
      end
    
  		if params[:user][:job_settings] && params[:user][:job_settings].nil?
  		  @user.update_column('job_settings', {})
  		  @jobs = Job.all
  		  redirect_to jobs_url
  	  end
  	end
	  
		if @user.update_attributes(user_params)
			flash[:success] = 'Your profile was updated successfully.'
			sign_in(@user)
			redirect_to jobs_url
		else
			render :edit
		end
	end


	def destroy
		user = User.find(params[:id])
		if user.destroy
		  flash[:welcome] = welcome_message
	  else
	    flash[:error] = "Unable to delete user"
    end
    
		redirect_to users_url
	end

	# PRIVATE ---------------------------------------------------------------------------
	private

    # TODO: is it security risk for is_admin
  	def user_params
  		params.require(:user).permit(:email, :password, :password_digest, :avatar, :fname, :lname, :title, :location,
  		  {job_settings: { keywords: [], dept: [], sub_dept: [], years_exp: [], key_skills: [] }}, :is_admin, :guest,
  		  :biography, :intro)
  	end
	
end

