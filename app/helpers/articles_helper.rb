module ArticlesHelper
  
  def find_tagging_id(article, tag)
    tagging = Tagging.where(article_id: article.id, tag_id: tag.id).first
    return tagging.id
  end
  
end