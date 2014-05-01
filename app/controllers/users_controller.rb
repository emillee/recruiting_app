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
			# redirect_to(@user)
      redirect_to root_url
		else
		  flash[:notice] = "didn't work"
			render :new
		end
	end

	def show
    set_tab('users')  	  	  
		@user = User.find(params[:id])
		@articles = @user.articles.order('updated_at DESC')
		@recent_articles = @articles.limit(3)
	end

	def update
    @user = User.find(params[:id])

    params[:user] = remove_blanks(params[:user], :job_settings, :keywords) unless params[:user].nil?
    params[:user] = remove_blanks(params[:user], :job_prefs, :company_stage) unless params[:user].nil?
    params[:user] = remove_blanks(params[:user], :job_prefs, :company_industry) unless params[:user].nil?

  	# if autcomplete sends back a company name (new company)
  	if params[:user] && params[:user][:company_id] && params[:user][:company_id].to_i == 0
  	  company = Company.create(name: params[:user][:company_id])
  	  params[:user][:company_id] = company.id
  	  @user.update_column('company_id', company.id)
	  end
	  
	  # WHEN UPDATING ARTICLE
    article_id = params[:user][:article_id] if params[:user]
    @user.store_article_id_temporarily(article_id)    
	  
		if @user.update_attributes(user_params)
			flash[:success] = 'Your profile was updated successfully.'
			sign_in(@user)
		end
		
		if params[:user] && (params[:user][:job_settings] || params[:user][:job_prefs])
		  redirect_to jobs_url
	  elsif params[:user] && params[:user][:company_settings]
	    redirect_to companies_url
    elsif params[:user] && params[:user][:article_id]
      redirect_to user_url(@user)
    else
			redirect_to :back
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
  		params.require(:user).permit(
		    :is_admin, :guest, :biography, :intro, :interested_in_meeting, :investor_company_id, :snapshots,
  		  :email, :password, :password_digest, :avatar, :fname, :lname, :title, :location, :company_id, :location_from,
  		  {job_settings: { keywords: [], dept: [], sub_dept: [], years_exp: [], key_skills: [] }},
  		  {job_prefs: { company_stage: [], company_industry: [], salary_buckets: [], equity_buckets: [] }},  		
  		  {company_settings: { company_stage: [] }}
  		)
  	end

    def remove_blanks(params, cat, sub_cat)
      no_blanks = []
      
      if params[cat] && params[cat][sub_cat]
        params[cat][sub_cat].each do |item|
          no_blanks << item if item != ''
          no_blanks.empty? ? params[cat].delete(sub_cat) : params[cat][sub_cat] = no_blanks
        end
      end

      params    
    end
	
end
















