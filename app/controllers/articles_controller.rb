class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.create
    UserArticle.create(user_id: current_user.id, article_id: @article.id)
    redirect_to article_url(@article)
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end  
  
  def create
    @article = Article.new
    if params[:article].nil? && params[:investor_id]
      Article.create(investor_id: params[:investor_id])
    else
      @article.save(article_params)
    end
    
    redirect_to :back
  end
  
  def update
    @article = Article.find(params[:id])
    
    if @article.update_attributes(article_params)
      if params[:company_id]
        company = Company.find(params[:company_id])
        redirect_to company_url(company)
      elsif params[:investor_id]
        investor = Investor.find(params[:investor_id])
        redirect_to investor_url(investor)
      else
        render @article
      end
    end
  end
  
  def destroy
    article = Article.find(params[:id])
    article.destroy
    redirect_to :back
  end
    
  #---------------------------------------------------------------------------------------
  private
  
  def article_params
    params.require(:article).permit(:title, :body, :link, :author_id, :tag_id, :company_id, :investor_id)
  end
  
end