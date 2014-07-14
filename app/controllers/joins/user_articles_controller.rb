class UserArticlesController < ApplicationController
  
  def create 
    UserArticle.create(article_id: article.id, user_id: user_id)
  end

  def index
  	@articles = Article.all
  end
  
end