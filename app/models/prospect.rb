class Prospect < ActiveRecord::Base

	include Filterable

  scope :has_email, where('email IS NOT NULL')
  scope :no_email, where('email IS NULL')

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

	def get_info_from_github
		github_url = "https://github.com/" + self.github_username
		html = HTTParty.get(github_url)
		doc = Nokogiri.HTML(html)

		self.company = doc.css("li[itemprop='worksFor']").text
		self.website = doc.css("li[itemprop='url']").text
		self.github_followers = doc.css(".vcard-stat-count")[0].text.to_i
		self.github_stars = doc.css(".vcard-stat-count")[1].text.to_i
		self.github_following = doc.css(".vcard-stat-count")[2].text.to_i
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
			if self.li_title = doc.css('li.b_algo')[0].css('li')[0].text
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