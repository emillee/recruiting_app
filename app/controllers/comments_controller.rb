class CommentsController < ApplicationController

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			ArticleComment.create(article_id: params[:article_id], comment_id: @comment.id)
		end

		redirect_to :back
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
	end

	#---------------------------------------------------------------------------------------
	private
	
	def comment_params
		params.require(:comment).permit(:body)
	end	

end