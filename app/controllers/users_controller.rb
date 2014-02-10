class UsersController < ApplicationController
    
	def new
		@user = User.new
	end

  def edit
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
		@user = User.find(params[:id])
	end

	def update
    @user = User.find(params[:id])
    
    keywords_arr = params[:user][:job_settings][:keywords]
    without_blanks = []
    
    if keywords_arr
      keywords_arr.each do |keyword|
        without_blanks << keyword unless keyword == ""
      end
    end
    
    if without_blanks.empty?
      params[:user][:job_settings].delete(:keywords)
    else
      params[:user][:job_settings][:keywords] = without_blanks
    end
    
    # this is if all checkboxes are blank or clear button hit. 
    # The empty search input box submits ""
    # Is there a better way to do this?
		if params[:user][:job_settings].nil?
		  @user.update_column('job_settings', {})
		  @jobs = Job.all
		  redirect_to jobs_url
		elsif @user.update_attributes(user_params)
			flash[:success] = 'Your profile was updated successfully.'
			sign_in(@user)
			redirect_to jobs_url
		else
			render :edit
		end
		
	end

	def index
		@users = User.all
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

	#-------------------------------------------------------------------------
	private

    # To fix: is it security risk for is_admin
  	def user_params
  		params.require(:user).permit(:email, :password, :password_digest, 
  		  {job_settings: { keywords: [], dept: [], experience: [] }}, :is_admin, :guest)
  	end
	
end

