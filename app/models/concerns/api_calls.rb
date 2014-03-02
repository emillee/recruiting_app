module ApiCalls
  extend ActiveSupport::Concern
  
  def get_crunchbase_info
    base_uri = "http://api.crunchbase.com/v/1/company/"
    name = "#{self.name.gsub(/\s/, '#')}"
    request_uri = ".js?api_key=#{ENV['CRUNCHBASE_KEY']}"
    
    begin
      response = HTTParty.get(base_uri + name + request_uri)
      response = JSON.parse(response.body)
    rescue
      nil
    end
    
    if response && response["error"].nil?
      company = Company.find_by_name(response["name"])
      if company
        company.num_employees = response["number_of_employees"]
        company.year_founded = response["founded_year"]
        company.overview = ActionView::Base::full_sanitizer.sanitize(response["overview"])
        company.total_money_raised = response["total_money_raised"]
        company.twitter_username = response["twitter_username"]
        company.category_code = response["category_code"]
        unless response["offices"][0].nil?
          company.city = response["offices"][0]["city"]
        end
        company.save
      end
    end
  end
  
  def get_twitter_followers
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_KEY"]
      config.consumer_secret = ENV["TWITTER_SECRET"]
    end
    
    if self.twitter_username
      self.twitter_followers = twitter_client.user(self.twitter_username).followers_count
      self.save
    end
  end
  
end