module CompaniesHelper
  
  def get_unique_tags(company)
    unique_tags = []
    
    company.articles.each do |article|
      article.tags.each do |tag|
        unique_tags << tag.tag_name
      end
    end
    
    unique_tags.uniq!
    return unique_tags
  end
  
  def add_placeholders_if_nil(section, text)
    return text unless text.nil?
    
    case section
    when 'title'
      return '<h1>Put Title Here</h1>'
    when 'body'
      return '<p>Put body here</p>'
    end
  end
  
  # def add_placeholders_if_nil(section, text_val)
  #   h1_str = '<h1>' + section + '</h1>'
  #   if text_val.empty?
  #     p_str  = '<p>Type text here</p>'
  #   else
  #     p_str = '<p>' + text_val + '</p>'
  #   end
  #   
  #   text = h1_str + p_str
  #   return text
  # end  
  
end