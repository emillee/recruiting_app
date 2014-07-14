class Admin::SkillsController < SkillsController

	def index
		@skills = Skill.all
	end

	def create
		super
	end

	def destroy
		super
	end

	def update
		super
	end

end