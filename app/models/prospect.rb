class Prospect < ActiveRecord::Base

	def self.create_from_link_pages(start, stop)
		first_part = 'https://github.com/search?l=PHP&p='
		last_part = '&q=location%3Anew%2Byork&ref=searchresults&type=Users'
		counter = start

		until counter > stop
			link = first_part + counter.to_s + last_part
			Prospect.create_from_link(link)
			counter += 1
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
			prospect.language = "PHP"
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