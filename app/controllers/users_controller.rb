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
  	
  	# if autcomplete sends back a company name (new company)
  	if params[:user] && params[:user][:company_id] && params[:user][:company_id].to_i == 0
  	  company = Company.create(name: params[:user][:company_id])
  	  params[:user][:company_id] = company.id
  	  @user.update_column('company_id', company.id)
	  end
	  
	  # WHEN UPDATING ARTICLE
    article_id = params[:user][:article_id] if params[:user]
    # params[:user].delete(:article_id) if params[:user]
    @user.store_article_id_temporarily(article_id)    
	  
	  
		if @user.update_attributes(user_params)
			flash[:success] = 'Your profile was updated successfully.'
			sign_in(@user)
		end
		
		if params[:user] && params[:user][:job_settings]
		  redirect_to jobs_url
	  elsif params[:user] && params[:user][:company_settings]
	    redirect_to companies_url
    elsif params[:user] && params[:user][:article_id]
      redirect_to user_url(@user)
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
	
  def delete_snapshot
    @user = User.find(params[:id])
    article = Article.find(params[:article_id])
    article_id = article.id
    
    size_arr = %w(large medium original)
    full_path = "#{Rails.root}/" + "public" + params[:path]
    
    if article.body.include?(params[:path])
      remove_img_section = article.body.scan(/<div class="article-#{article_id}.*end-of-image-div -->/m)[0]
      body = article.body
      body.slice!(remove_img_section)
      article.update_columns(body: body)
    end

    current_size = nil    
    size_arr.each do |size|
      current_size = size if full_path.include?(size)
    end
    
    size_arr.each do |size|
      this_path = full_path.gsub(current_size, size)
      File.delete(this_path) 
    end
    
    redirect_to investor_url(@investor)
  end	

	# PRIVATE ---------------------------------------------------------------------------
	private

    # TODO: is it security risk for is_admin
  	def user_params
  		params.require(:user).permit(:email, :password, :password_digest, :avatar, :fname, :lname, :title, :location, :company_id,
  		  {job_settings: { keywords: [], dept: [], sub_dept: [], years_exp: [], key_skills: [] }}, :is_admin, :guest,
  		  :biography, :intro, :interested_in_meeting, :investor_company_id, :snapshots)
  	end
	
end

