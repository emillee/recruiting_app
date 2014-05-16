class Admin::CompaniesController < Admin::ApplicationController

	def show
		@company = Company.find(params[:id])
		@job = Job.new
	end

end