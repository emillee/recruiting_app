module CompaniesHelper
  
  def return_uniq_categories
    unique_cats = []
    Company.all.each do |company|
      unique_cats << company.category_code if company.category_code
    end
    
    unique_cats.uniq!
    unique_cats
  end
  
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
  
end