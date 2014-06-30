class ArticlesController < ApplicationController

  def index
    if request.subdomain == 'blog'
      @user = User.find(77)
      @articles = @user.articles
    elsif params[:company_id]
      @company = Company.find(params[:company_id])
      @articles = @company.articles
    else
      @articles = Article.all
    end
  end

  def new
    @article = Article.create
    @user = current_user
    UserArticle.create(article_id: @article.id, user_id: @user.id)
    redirect_to edit_user_article_url(@user, @article)
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @article = Article.find(params[:id])
  end  
  
  def create
    @article = Article.new
    if params[:article].nil? && params[:investor_id]
      Article.create(investor_id: params[:investor_id])  
    else 
      @article.save(article_params) && params[:user_id]
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