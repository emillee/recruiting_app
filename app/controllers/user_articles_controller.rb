class UserArticlesController < ApplicationController
  
  def create 
    article = Article.create if params[:article_id].nil?
    user_id = params[:user_id]
    
    UserArticle.create(article_id: article.id, user_id: user_id)
    redirect_to user_url(user_id)
  end

  def index
  	@articles = Article.all
  end
  
end