class Company < ActiveRecord::Base
  
  validates :name, presence: true
  
  scope :career_page_available, lambda { where('companies.career_page_link IS NOT NULL AND 
    companies.career_page_link != ?', 'NA') }
  
  has_many(
    :job_listings,
    class_name: 'Job',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  # To fix: this needs a lot of work
  def self.search(settings_hash)
    if settings_hash.empty?
      companies = self.all
    else
      if settings_hash[:keywords]
        settings_hash[:keywords].each do |search_query|
          companies = where("name @@ :q", q: search_query)      
        end
      else
        companies = self.all
      end
    end
    
    companies
  end
  
  def self.all_company_names
    all_names = Company.all.map(&:name).uniq!
    all_names
  end
  
  # SCRATCH FORMULAS FOR COMPANIES ---------------------------
  def get_crunchbase_info
    base_uri = "http://api.crunchbase.com/v/1/company/"
    name = "#{self.name.gsub(/\s/, '#')}"
    request_uri = ".js?api_key=#{ENV['CRUNCHBASE_KEY']}"
    begin
      response = HTTParty.get(base_uri + name + request_uri)
    rescue
      nil
    end
    
    if response && response["error"].nil?
      company = Company.find_by_name(response["name"])
      if company
        company.num_employees = response["number_of_employees"]
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








