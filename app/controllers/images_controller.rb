class ImagesController < ApplicationController

	def create
		@image = Image.new(image_params)
		@image.save!
		redirect_to :back
	end

	def destroy
		@image = Image.find(params[:id]).destroy
		redirect_to :back
	end

	def remove
    image_id = params[:id]
    article = Article.find(params[:article_id])
    
    size_arr = %w(original thumb)
    full_path = "#{Rails.root}/" + "public" + params[:path].split('?')[0]
    
    if article.body.include?(params[:path].split('?')[0])
      remove_img_section = article.body.scan(/<div class="image-id-#{image_id}.*end-of-image-div -->/m)[0]
      body = article.body
      body.slice!(remove_img_section)
      article.update_columns(body: body)
    end

    current_size = nil    
    size_arr.each do |size|
      current_size = size if full_path.include?(size)
    end
    
    size_arr.each do |size|
      this_path = full_path.gsub(current_size, size)
      File.delete(this_path) 
    end		

    redirect_to :back
	end


	private

		def image_params
			params.require(:image).permit(:image_file, :article_id)
		end

end