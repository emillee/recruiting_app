class ArticlesController < ApplicationController
  
  def create
  end
  
  def update
    @article = Article.find(params[:id])
    @company = Company.find(params[:company_id])
    if @article.update_attributes(article_params)
      redirect_to company_url(@company)
    end
  end
    
  #------------------------------------------------------------------------------
  private
  
    def article_params
      params.require(:article).permit(:title, :body, :author_id, :tag_id, :company_id)
    end
  
end