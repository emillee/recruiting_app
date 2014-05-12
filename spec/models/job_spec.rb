require 'spec_helper'

# Job(id: integer, link: string, created_at: datetime, updated_at: datetime, 
# 	title: string, full_text: text, is_draft: boolean, company_id: integer, 
# 	dept: string, years_exp: integer, sub_dept: string, description: text, 
# 	key_phrases: string, req_skills: string)

describe 'Job' do

	let(:company) { FactoryGirl.create(:company) }

	before { @job = company.job_listings.build(
		link: 'https://www.linktojob.com',
		title: 'Lead Developer',
		full_text: 'Come join us at...'
	)}

	it "should have a company" do
		@job = Job.new
		@job.save
		@job.should_not be_valid
	end

	it "should be associated with the company that built it" do
		@job.save
		@job.company_id { should == company.id }
	end


end