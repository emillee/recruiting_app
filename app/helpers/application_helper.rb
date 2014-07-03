module ApplicationHelper

  include FacebookHelper
  include ArticlesHelper
  include PermissionsHelper

  def article_helper(word) 
  	first_char = word[0]
  	vowels = %w(a e i o u)
  	if vowels.include?(first_char)
  		return "an #{word}"
  	else
  		return "a #{word}"
  	end
  end

end
