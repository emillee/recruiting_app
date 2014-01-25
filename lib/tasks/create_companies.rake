desc "Create companies from url"

task create_companies_from_url: :environment do
  url = "http://wearemadeinny.com/made-in-ny-list/"
  html = Nokogiri::HTML(open(url))
  links = html.at_css('.active a')
  links = html.css('a')

  unfiltered_arr = [] 

  links.each do |link|
  	unfiltered_arr << link.text.strip
  end

  first_pos = unfiltered_arr.index('10Gen')
  new_arr = unfiltered_arr.drop(first_pos)
  last_pos = new_arr.index('ZocDoc')
  comp_arr = new_arr.slice(0,last_pos + 1)

  comp_arr.each do |name|
    Company.create!(name: name)
  end
  
end