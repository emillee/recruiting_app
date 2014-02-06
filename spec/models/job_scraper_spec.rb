require 'spec_helper'
  
describe "job_scraper" do
  
  describe "years" do
    let(:job)       { Job.new(link: "http://songza.com/page/careers/") }
    let(:job_scraper) { JobScraper.new(job) }    
    let(:other_job) { Job.new(link: "http://www.mongodb.com/careers/positions/associate-technical-services-engineer") }
    let(:other_job_scraper) { JobScraper.new(other_job) } 
  
    it "finds the right number of years when specified as number +" do
      job_scraper.input_job_data
      job.reload
      job.years_exp.should == 2
    end
    
    it "finds the right number of years when specified as number #-#" do
      other_job_scraper.input_job_data
      other_job.reload
      other_job.years_exp.should == 2
    end
  end
  
end
  
