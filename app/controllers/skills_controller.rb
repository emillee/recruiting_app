class SkillsController < ApplicationController

	respond_to :html, :js, :json

	def index
		@skills = Skill.all
	end

	def create
		@skill = Skill.where(
			skill_name: params[:skill][:skill_name], 
			skill_dept: params[:skill][:skill_dept], 
			skill_sub_dept: params[:skill][:skill_sub_dept]
		).first

		if !@skill.nil?
			if params[:skill][:preferred_phrases]
				@skill.preferred_phrases_will_change!
				@skill.preferred_phrases += params[:skill][:preferred_phrases]
			end

			if params[:skill][:required_phrases]
				@skill.required_phrases_will_change!
				@skill.required_phrases += params[:skill][:required_phrases]
			end
		else
			@skill = Skill.new(skill_params)
		end
		
		@skill.save
		redirect_to :back
	end

	def update
		@skill = Skill.find(params[:id])
		
		if params[:skill][:preferred_phrases]
			@skill.preferred_phrases_will_change!
			@skill.preferred_phrases << params[:skill][:preferred_phrases]
		end

		if params[:skill][:required_phrases]
			@skill.required_phrases_will_change!
			@skill.required_phrases << params[:skill][:required_phrases]
		end

		redirect_to :back
	end

	def destroy
		@skill = Skill.find(params[:id])
		@skill.destroy
	end

	# FOR TOKEN INPUT
	def name
		@skills = Skill.where('skill_name ilike ?', "%#{params[:q]}%")
		
		respond_to do |format|
			format.json { render json: @skills.map(&:attributes) }
		end
	end

	def dept
		@skills = Skill.where('skill_dept ilike ?', "%#{params[:q]}%")
		
		respond_to do |format|
			format.json { render json: @skills.map(&:attributes) }
		end
	end

	def sub_dept
		@skills = Skill.where('skill_sub_dept ilike ?', "%#{params[:q]}%")
		
		respond_to do |format|
			format.json { render json: @skills.map(&:attributes) }
		end
	end	

	# PRIVATE ---------------------------------------------------------------------------
	private

		def skill_params
			params.require(:skill).permit(:skill_name, :skill_dept, :skill_sub_dept, :logo, 
				required_phrases: [], preferred_phrases: [])
		end

end