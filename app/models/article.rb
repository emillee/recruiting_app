class Article < ActiveRecord::Base
  
  belongs_to :company
  belongs_to :investor
  
  has_many :taggings    
  has_many :tags, through: :taggings, source: :tag
  
  has_many :user_articles  
  has_many :users, through: :user_articles, source: :user

  has_many :images

  def first_sentence
  	return nil if self.body.nil?
  	self.body.split(' ')[0..30].join(' ')
  end

  def author 
    self.users.first
  end

end
