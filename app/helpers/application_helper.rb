module ApplicationHelper
  include FacebookHelper
  include ArticlesHelper

  def normalize_string(str)
    new_str = str.downcase.gsub(/[^a-z0-9\s]/, '').strip.gsub(/\s/, '-')
    return new_str
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
  
  def insert_br(string, index)
    words_arr = string.split(' ')
    new_str_arr = words_arr[0..index]
    new_str_arr += ['<br>'] 
    new_str_arr += words_arr[(index + 1)..-1]
    new_str = new_str_arr.join(' ')
    new_str
  end
  
  def show_keywords?
    current_user.job_settings[:keywords]
  end  
  
end
