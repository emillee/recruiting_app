class ArticleTopicsController < ApplicationController

	def create
		@article_topic = ArticleTopic.new(article_topic_params)
		@article_topic.save
	end

	def destroy
		@article_topic = ArticleTopic.find(params[:id])
		@article_topic.destroy
	end

	#---------------------------------------------------------------------------------------
	private 

	def article_topic_params
		params.require(:topic).permit(:article_id, :topic_id)
	end

end