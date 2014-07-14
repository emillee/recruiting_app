class Article < ActiveRecord::Base
  
  belongs_to :company
  belongs_to :investor
  
  has_many :taggings    
  has_many :tags, through: :taggings, source: :tag
  
  has_many :user_articles  
  has_many :users, through: :user_articles, source: :user

  has_many :article_topics
  has_many :topics, through: :article_topics, source: :topic

  has_many :article_comments
  has_many :comments, through: :article_comments, source: :comment

  has_many :images

  include Recommend

  def self.my_articles(current_user)
    current_user.articles
  end

  def first_sentence
  	return nil if self.body.nil?
  	self.body.split(' ')[0..30].join(' ')
  end

  def author 
    self.users.first
  end

  def increase_view_count
    self.views = self.views + 1
    self.save
  end

end
