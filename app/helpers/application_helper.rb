module ApplicationHelper
  include FacebookHelper
  
  def insert_br(string, index)
    words_arr = string.split(' ')
    new_str_arr = words_arr[0..index]
    new_str_arr += ['<br>'] 
    new_str_arr += words_arr[(index + 1)..-1]
    new_str = new_str_arr.join(' ')
    new_str
  end
  
end
