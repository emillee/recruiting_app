class JobRanker

	attr_reader :job
	attr_writer :job

	DEPT_WEIGHT = 10
	SUB_DEPT_WEIGHT = 10
	YEARS_EXP_WEIGHT = 10
	KEY_SKILLS_WEIGHT = 10

	def initialize(job, user)
		@job = job
		@job.job_score = 0
		@company = @job.listing_company
		@user = user
		@job.job_score_tracker = []
		calculate_job_score
	end

	def calculate_job_score
		# dept_relevance
		sub_dept_relevance
		years_exp_relevance
		key_skills_relevance
		@job
	end

	# from current_user.job_settings
	# def dept_relevance
	# 	user_depts = @user.job_settings[:dept]
	# 	job_dept = @job.dept

	# 	if user_depts && user_depts.include?(job_dept)
	# 		@job.job_score += DEPT_WEIGHT
	# 	end
	# end

	def sub_dept_relevance
		user_sub_depts = @user.job_settings[:sub_dept]
		job_sub_dept = @job.sub_dept
		match = user_sub_depts.index(job_sub_dept)

		if match
			@job.job_score += SUB_DEPT_WEIGHT
			@job.job_score_tracker << [user_sub_depts[match], SUB_DEPT_WEIGHT]
		end		
	end 


	def years_exp_relevance
		user_years_exp = @user.job_settings[:years_exp].nil? ? nil : @user.job_settings[:years_exp].map(&:to_i) 
		job_years_exp = @job.years_exp

		if user_years_exp
			if user_years_exp.include?(job_years_exp)
				@job.job_score += YEARS_EXP_WEIGHT
				@job.job_score_tracker << ["user: #{user_years_exp} job: #{job_years_exp}", YEARS_EXP_WEIGHT]
			elsif user_years_exp.map { |x| x + 1 }.include?(job_years_exp)
				@job.job_score += YEARS_EXP_WEIGHT / 2
				@job.job_score_tracker << ["user: #{user_years_exp} job: #{job_years_exp}", YEARS_EXP_WEIGHT / 2]
			elsif user_years_exp.map { |x| x - 1 }.include?(job_years_exp)
				@job.job_score += YEARS_EXP_WEIGHT / 2
				@job.job_score_tracker << ["user: #{user_years_exp} job: #{job_years_exp}", YEARS_EXP_WEIGHT / 2]
			elsif user_years_exp.map { |x| x + 2 }.include?(job_years_exp)
				@job.job_score += YEARS_EXP_WEIGHT / 4
				@job.job_score_tracker << ["user: #{user_years_exp} job: #{job_years_exp}", YEARS_EXP_WEIGHT / 4]
			elsif user_years_exp.map { |x| x - 2 }.include?(job_years_exp)
				@job.job_score += YEARS_EXP_WEIGHT / 4
				@job.job_score_tracker << ["user: #{user_years_exp} job: #{job_years_exp}", YEARS_EXP_WEIGHT / 4]
			end
		end
	end 

	def key_skills_relevance
		user_key_skills = @user.job_settings[:key_skills] || @user.tech_stack.map(&:skill_name).uniq
		job_key_skills = @job.req_skills || @company.tech_stack.map(&:skill_name).uniq

    skill_matches_arr = (user_key_skills & job_key_skills)
    job.job_score += KEY_SKILLS_WEIGHT * skill_matches_arr.count

    @job.job_score_tracker << ["user: #{user_key_skills} job: #{job_key_skills}", 
    	KEY_SKILLS_WEIGHT * skill_matches_arr.count]
	end 

	# from current_user.company_settings
	def company_stage_relevance
	end 

	def company_industry_relevance
	end 	

	# other relevancy scores
	def recent_score
	end

end