class ProspectsController < ApplicationController

	def index
		if current_user.prospect_settings.any? 
			@prospects = Prospect.return_matches(current_user)
		else
			@prospects = Prospect.all.order('id DESC').limit(10)
		end
	end


	#---------------------------------------------------------------------------------------
	private

	def prospect_params
		params.require(:prospect).permit(:github_username, :first_name, :last_name, 
			:city_github, :date_joined_github, :email, :language, :company_github, :website_github, 
			:github_followers, :github_stars, :github_following, :num_repos, :github_languages, :yrs_on_github,
			:li_url, :li_title, :li_company)	
	end


end