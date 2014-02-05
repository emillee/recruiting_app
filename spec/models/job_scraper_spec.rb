require 'spec_helper'
  
describe "job_scraper" do
  
  describe "years" do
    let(:job) { Job.new(link: "http://songza.com/page/careers/") }
    let(:job_scraper) { JobScraper.new(job) }    
  
    it "finds the right number of years when specified as number +" do
      job_scraper.input_job_data
      job.reload
      job.years_exp.should == 2
    end
  
  end
  
end
  
