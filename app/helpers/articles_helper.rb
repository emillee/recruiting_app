module ArticlesHelper

  # get rid of anything that isn't a letter or number, replace spaces with dashes
  def normalize_string(str)
    new_str = str.downcase.gsub(/[^a-z0-9\s]/, '').strip.gsub(/\s/, '-')
    return new_str
  end  

  # get all article tags, return as one string (with spaces)
  def insert_tag_ids(article)
    article.tags.map { |tag| "tag-id-#{tag.id}" }.join(' ')
  end	
  
  def find_tagging_id(article, tag)
    tagging = Tagging.where(article_id: article.id, tag_id: tag.id).first
    return tagging.id
  end

  def add_placeholders_if_nil(section, text)
    return text unless text.nil? || text.empty?
    
    case section
    when 'title'
      return '<h1>Put Title Here</h1>'
    when 'body'
      return '<p>Put body here</p>'
    end
  end    
  
end