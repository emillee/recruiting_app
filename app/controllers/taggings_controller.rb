class TaggingsController < ApplicationController
  
  def show
  end
  
  
  def create
    @article = Article.find(params[:tagging][:article_id])
    session[:return_to] ||= request.referer
    
    if params[:tagging][:tag_id].to_i == 0
      return if params[:tagging][:tag_id].squish == ""
      tag = Tag.where('tag_name = ?', params[:tagging][:tag_id].downcase.squeeze(' '))
      if tag && !@article.tags.include?(tag)
        tag = Tag.create(tag_name: params[:tagging][:tag_id].squeeze(' '))
        params[:tagging][:tag_id] = tag.id
        @tagging = Tagging.new(tagging_params)
        @tagging.save
      end
    else 
      @tagging = Tagging.new(tagging_params)
      @tagging.save      
    end
  
    redirect_to session.delete(:return_to)
  end
  
  def destroy    
    @tagging = Tagging.find(params[:id])
    @tagging.destroy
    
    # BACKNOL HELP
    # redirect_to controller: 'users', action: 'show', id: current_user.id
  end
  
	# PRIVATE ---------------------------------------------------------------------------
  private
  
    def tagging_params
      params.require(:tagging).permit(:article_id, :tag_id)
    end
  
end