class InvestorsController < ApplicationController
  
  before_filter :set_this_tab, only: [:index, :show]

  def index
    @investors = Investor.all
  end
  
  def show
    @investor = Investor.find(params[:id])
  end
  
  def update
    @investor = Investor.find(params[:id])
    
    article_id = params[:investor][:article_id] if params[:investor]
    params[:investor].delete(:article_id) if params[:investor]
    @investor.store_article_id_temporarily(article_id)    
    
    if @investor.update_attributes(investor_params)
      redirect_to investor_url(@investor)
    else
      render :edit
    end
  end
  
  #---------------------------------------------------------------------------------------
  private 
  
  def investor_params
    params.require(:investor).permit(:name, :snapshots, :article_id, :neighborhood, :logo,
      :about, stage:[], check_size:[])
  end

  def set_this_tab
    set_tab('investors')
  end
  
end







