class ArticlesController < ApplicationController

  before_filter :set_this_tab, only: [:index, :show]

  # def index
  #   if request.subdomain == 'blog'
  #     @user = User.find(77)
  #     @articles = @user.articles
  #   elsif params[:company_id]
  #     @company = Company.find(params[:company_id])
  #     @articles = @company.articles
  #   else
  #     @articles = Article.all
  #   end
  # end

  # def new
  #   @article = Article.create
  #   @user = current_user
  #   UserArticle.create(article_id: @article.id, user_id: @user.id)
  #   redirect_to edit_user_article_url(@user, @article)
  # end

  def create
    @article = Article.new(article_params)
    
    if @article.save
      UserArticle.create(article_id: @article.id, user_id: current_user.id)
      topic = create_or_return_topic(params[:topic_id], @article.id) if params[:topic_id]
      tag = create_or_return_tag(topic.id, params[:tag_id]) if (params[:tag_id] && topic)
      create_article_tag(@article.id, tag.id) if tag
    end
    
    redirect_to articles_url
  end


  def index
    @comment = Comment.new

    if params['new_article'] == 'true'
      @new_article = Article.new
    end

    if params['my_articles'] == 'true'
      @articles = Article.my_articles(current_user)
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @user = User.find(params[:user_id])
    @article = Article.find(params[:id])
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

  def increase_views
    @article = Article.find(params[:id])
    if @article.increase_view_count
      redirect_to articles_url, status: 303
    end
  end

  def increase_recs
    @article = Article.find(params[:id])
    if @article.increase_recs
      redirect_to articles_url, status: 303
    end
  end
    
  #---------------------------------------------------------------------------------------
  private
  
  def article_params
    params.require(:article).permit(:title, :body, :link, :author_id, 
      :tag_id, :company_id, :investor_id, :views, :recs)
  end

  def set_this_tab
    set_tab('articles')
  end

  def create_or_return_topic(topic_id, article_id)
    if topic_id && topic_id.to_i != 0
      @topic = Topic.find(topic_id.to_i)
      ArticleTopic.create(article_id: article_id, topic_id: topic_id.to_i)
    elsif topic_id && topic_id.to_i == 0
      if !Topic.where('name @@ ?', topic_id).empty?
        @topic = Topic.where('name @@ ?', topic_id).first
        ArticleTopic.create(article_id: article_id, topic_id: @topic.id)
      else
        @topic = Topic.new(name: topic_id)

        if @topic.save
          ArticleTopic.create(article_id: article_id, topic_id: @topic.id)
        end
      end
    end

    return @topic
  end


  def create_or_return_tag(topic_id, tag_id)
    if tag_id && tag_id.to_i != 0
      @tag = Tag.find(tag_id.to_i)
      TopicTag.create(topic_id: topic_id, tag_id: tag_id.to_i)
    elsif tag_id && tag_id.to_i == 0
      if !Tag.where('tag_name @@ ?', tag_id).empty?
        @tag = Tag.where('tag_name @@ ?', tag_id).first
        TopicTag.create(topic_id: topic_id, tag_id: @tag.id)
      else
        @tag = Tag.new(tag_name: tag_id)

        if @tag.save
          TopicTag.create(topic_id: topic_id, tag_id: @tag.id)
        end
      end
    end

    return @tag
  end  
  
  def create_article_tag(article_id, tag_id)
    Tagging.create(article_id: article_id, tag_id: tag_id)
  end

end








