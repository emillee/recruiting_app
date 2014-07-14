class ArticleCommentsController < ApplicationController

	def create
		@article_comment = ArticleComment.new(article_comment_params)
		@article_comment.save
	end

	def destroy
		@article_comment = ArticleComment.find(params[:id])
		@article_comment.destroy
	end

	#---------------------------------------------------------------------------------------
	private 

	def article_comment_params
		params.require(:article_comment).permit(:article_id, :comment_id)
	end

end