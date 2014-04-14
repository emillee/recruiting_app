class TagsController < ApplicationController
  
  respond_to :html, :js, :json
  
  def index
    @tags = Tag.all
    
    if params[:q] 
      @tags = Tag.where("tag_name ilike ?", "%#{params[:q]}%")
    end
    
    respond_to do |format|
      format.html      
      format.json { render json: @tags.map(&:attributes) }      
    end
  end
  
  def update
  end
  
  def new
  end
  
end