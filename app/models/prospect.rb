class Prospect < ActiveRecord::Base

	include Filterable

  scope :has_email, -> { where('email IS NOT NULL') }
  scope :no_email, -> { where('email IS NULL') }

  def self.return_matches(user)
  	scopes = []
  	scopes << :has_email if user.prospect_settings[:has_email].include?('true')
  	scopes << :no_email if user.prospect_settings[:has_email].include?('false')
  	prospects = []

  	scopes.each do |scope|
  		prospects += Prospect.public_send(scope)
  	end

  	prospects
  end 

	def self.create_from_link_pages(start, stop)
		# first_part = 'https://github.com/search?l=PHP&p='
		# last_part = '&q=location%3Anew%2Byork&ref=searchresults&type=Users'

		first_part = 'https://github.com/search?l=C%23&p='
		last_part = '&q=location%3Anew%2Byork&ref=searchresults&type=Users'
		counter = start

		until counter > stop
			link = first_part + counter.to_s + last_part
			Prospect.create_from_link(link)
			counter += 1
		end
	end

	def self.collect_data_on_prospects(start_id, stop_id)
		(start_id..stop_id).to_a.each do |id|
			prospect = Prospect.find(id)
			next unless prospect
			prospect.get_info_from_github
			prospect.get_linkedin_url_from_bing
			prospect.get_repo_info
		end
	end

	def get_repo_info
		google_query = 'https://www.google.com/search?q=github+' + self.github_username
		html = HTTParty.get(google_query)
		doc = Nokogiri.HTML(html)	
		
		if doc.css('cite')[0].text == ("https://github.com/" + self.github_username)
			repo_str = doc.css('.st')[0].text
			self.num_repos = repo_str.scan(/\d repositor/)[0].split(' ')[0].to_i if repo_str.scan(/\d repositor/)[0]
			lang_arr = repo_str.split(/written in /)[1].split(/. Follow/)[0].split(', ') if repo_str.split(/written in /)[1]
			lang_arr[lang_arr.length-1] = lang_arr[lang_arr.length-1].gsub('and ', '') if lang_arr
			self.github_languages += lang_arr if lang_arr
			self.github_languages = self.github_languages.uniq if github_languages
		end

		self.yrs_on_github = self.convert_str_to_years_float
		self.save
	end

	def convert_str_to_years_float
		date_joined = self.date_joined_github.split(/Joined on /)[1].to_date
		years = (Time.now.to_date - date_joined.to_date)/365
		years_rounded = (years * 2).round / 2.0
		years_rounded
	end

	def get_info_from_github
		github_url = "https://github.com/" + self.github_username
		html = HTTParty.get(github_url)
		doc = Nokogiri.HTML(html)

		self.company_github = doc.css("li[itemprop='worksFor']").text if doc.css("li[itemprop='worksFor']")
		self.website_github = doc.css("li[itemprop='url']").text if doc.css("li[itemprop='url']")
		self.github_followers = doc.css(".vcard-stat-count")[0].text.to_i if self.github_followers = doc.css(".vcard-stat-count")[0]
		self.github_stars = doc.css(".vcard-stat-count")[1].text.to_i if doc.css(".vcard-stat-count")[1]
		self.github_following = doc.css(".vcard-stat-count")[2].text.to_i if doc.css(".vcard-stat-count")[2]
		self.save
	end	

	def get_linkedin_url_from_bing
		query_start = 'http://www.bing.com/search?q='
		full_name = "'#{self.first_name}+#{self.last_name}'"
		linkedin = "+linkedin"
		location = "+New+York"
		keywords = "+programmer+developer"
		company = "+'#{self.company_github.split.join('+')}'" if self.company_github

		query = query_start + full_name + location + keywords 
		query = query + company if company
		p "query #{query}"
		
		html = HTTParty.get(query)
		doc = Nokogiri.HTML(html)
		linkedin_url_guess = doc.css('cite').text
		p "guess #{linkedin_url_guess}"

		if linkedin_url_guess.match(/www.linkedin.com/)
			extract = linkedin_url_guess.match(/linkedin.com.*/)[0].split('www')[0]
			self.li_url = "https://www." + extract
			if self.li_title = doc.css('li.b_algo')[0].css('li')[0]
				self.li_title = doc.css('li.b_algo')[0].css('li')[0].text.split(' at ')[0]
				self.li_company = doc.css('li.b_algo')[0].css('li')[0].text.split(' at ')[1]
			end
			
			self.save
		end
	end

	def self.create_from_link(link)
		html = HTTParty.get(link)
		doc = Nokogiri.HTML(html)

		githubs = doc.css('.user-list-item')

		divs = doc.css('.user-list-item')
		divs.each do |div|
			github_username = div.at_css('a.gravatar')['href'].gsub('/', '')
			arr = div.css('.user-list-info').inner_text.split("\n").map { |x| x.squish }.delete_if(&:empty?)
			email = div.css('a.email').inner_text

			prospect = Prospect.new
			prospect.language = "C#"
			prospect.city = "NYC"

			if arr.length <= 3
				prospect.github_username = arr[0]
				prospect.date_joined = arr.last
			else		
				prospect.github_username = arr[0]
				prospect.first_name = arr[1].split(' ')[0]
				prospect.last_name = arr[1].split(' ')[1]
				prospect.date_joined = arr.last
			end

			if email.empty?
				prospect.date_joined = arr[3] if prospect.date_joined.nil?
			else
				prospect.date_joined = arr[4] if prospect.date_joined.nil?
				prospect.email = email				
			end

			prospect.save!
		end

		# redirect_to admin_prospects_url
	end

end