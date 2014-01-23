class UsersController < ApplicationController
    
	def new
		@user = User.new
	end

  def edit
    @user = User.find(params[:id])
  end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in(@user)
			flash[:success] = "Welcome to NYTech.io!"
			redirect_to(@user)
		else
			render :new
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def update
    @user = User.find(params[:id])

		if params[:user].nil?
		  @user.job_settings = {}
		  @user.save
		  @jobs = Job.all
		  redirect_to jobs_url
		elsif 
		  @user.update_attributes(user_params)
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
		  flash[:success] = "User deleted"
	  else
	    flash[:error] = "Unable to delete user"
    end
    
		redirect_to users_url
	end

	#-------------------------------------------------------------------------
	private

	def user_params
		params.require(:user).permit(:email, :password, :password_digest, 
		  {job_settings: { category: [], experience: [] }})
	end
	
end

