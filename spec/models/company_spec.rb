require 'spec_helper'

describe 'Company' do

	it "should have a name" do
		company = Company.create
		company.should_not be_valid
	end

end