class Admin::ProspectsController < Admin::ApplicationController

	def create
		@prospect = Prospect.new(prospect_params)

		if @prospect.save
			respond_to do |format|
				format.html 
				format.json { render json: @prospect }
			end
		end
	end

	def index
		@prospects = Prospect.all.order('id DESC')
	end

	#---------------------------------------------------------------------------------------
	private

	def prospect_params
		params.require(:prospect).permit(:github_username, :first_name, :last_name, 
			:city, :date_joined, :email, :language)
	end

end