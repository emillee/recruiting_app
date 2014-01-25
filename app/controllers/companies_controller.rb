class CompaniesController < ApplicationController
  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to company_url
    end
  end

  def destroy
    @company.find(params[:id]).destroy
  end

  def edit
  end

  def update
  end

  def index
    @companies = Company.all
  end
  
  
  #------------------------------------------------------------------------------
	private
	def company_params
		params.require(:company).permit(:name)
	end
end
