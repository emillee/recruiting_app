class Article < ActiveRecord::Base
  
  belongs_to(
    :company,
    class_name: 'Company',
    foreign_key: :company_id,
    primary_key: :id
  )
  
  belongs_to(
    :investor,
    class_name: 'Investor',
    foreign_key: :investor_id,
    primary_key: :id
  )
  
  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :article_id,
    primary_key: :id
  )
  
  has_many(
    :tags,
    through: :taggings,
    source: :tag
  )
  
end