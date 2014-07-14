class Topic < ActiveRecord::Base

	has_many :article_topics
	has_many :articles, through: :article_topics, source: :article

	has_many :topic_tags
	has_many :tags, through: :topic_tags, source: :tag

end