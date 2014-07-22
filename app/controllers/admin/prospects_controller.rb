class Admin::ProspectsController < ProspectsController

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
		super
	end

	#---------------------------------------------------------------------------------------
	private

	def prospect_params
		super
	end

end