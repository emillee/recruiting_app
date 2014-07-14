class TopicTagsController < ApplicationController

	def create
		@topic_tag = TopicTag.new(topic_tag_params)
		@topic_tag.save
	end

	def destroy
		@topic_tag = TopicTag.find(params[:id])
		@topic_tag.destroy
	end

	#---------------------------------------------------------------------------------------
	private 

	def topic_tag_params
		params.require(:topic).permit(:topic_id, :tag_id)
	end

end