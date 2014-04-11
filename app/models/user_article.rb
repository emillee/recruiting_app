class UserArticle < ActiveRecord::Base
  
  belongs_to(
    :article,
    class_name: 'Article',
    foreign_key: :article_id,
    primary_key: :id
  )
  
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
end