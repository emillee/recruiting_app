class Comment < ActiveRecord::Base

	has_many :article_comments
	has_many :articles, through: :article_comments, source: :article

end