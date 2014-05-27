class ImagesController < ApplicationController

	def create
		@image = Image.new(image_params)
		@image.save!
	end

	def destroy
		@image = Image.find(params[:id]).destroy
	end


	private

		def image_params
			params.require(:image).permit(:image_file, :article_id)
		end

end