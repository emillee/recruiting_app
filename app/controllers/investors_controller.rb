class InvestorsController < ApplicationController
  
  def index
    set_tab('investors')
    @investors = Investor.all
  end
  
  def show
    set_tab('investors')
    @investor = Investor.find(params[:id])
  end
  
  def update
    @investor = Investor.find(params[:id])
    
    if @investor.update_attributes(investor_params)
      redirect_to investor_url(@investor)
    else
      render :edit
    end
  end
  
  
  private 
  
    def investor_params
      params.require(:investor).permit(:name, :neighborhood, :logo, stage:[], check_size:[])
    end
end