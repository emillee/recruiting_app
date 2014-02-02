class TaxonomiesController < ApplicationController
  
  def index
    @taxonomies = Taxonomy.all
    respond_to do |format|
      format.html
      format.csv { render text: @taxonomies.to_csv }
    end
  end
  
end
