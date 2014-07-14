class ArticleComment < ActiveRecord::Base

	belongs_to :comment
	belongs_to :article

end