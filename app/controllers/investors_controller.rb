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
  
  def delete_snapshot
    @investor = Investor.find(params[:id])
    article = Article.find(params[:article_id])
    article_id = article.id
    
    size_arr = %w(large medium original)
    full_path = "#{Rails.root}/" + "public" + params[:path]
    
    if article.body.include?(params[:path])
      remove_img_section = article.body.scan(/<div class="article-#{article_id}.*end-of-image-div -->/m)[0]
      body = article.body
      body.slice!(remove_img_section)
      article.update_columns(body: body)
    end

    current_size = nil    
    size_arr.each do |size|
      current_size = size if full_path.include?(size)
    end
    
    size_arr.each do |size|
      this_path = full_path.gsub(current_size, size)
      File.delete(this_path) 
    end
    
    redirect_to investor_url(@investor)
  end  
  
  
  private 
  
    def investor_params
      params.require(:investor).permit(:name, :snapshots, :article_id, :neighborhood, :logo,
        :about, stage:[], check_size:[])
    end

    def set_this_tab
      set_tab('investors')
    end
end







