class TopicsController < ApplicationController

	def create
		@topic = Topic.new(topic_params)
	end

	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy
	end

	#---------------------------------------------------------------------------------------
	private 

	def topic_params
		params.require(:topic).permit(:name)
	end

end