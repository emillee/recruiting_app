class Skill < ActiveRecord::Base

	validates :skill_name, presence: true
	validates :skill_dept, presence: true
	validates :skill_sub_dept, presence: true

	before_save { self.skill_name = self.skill_name.downcase.split(' ').join('-') }
	before_save { self.skill_dept = self.skill_dept.downcase.split(' ').join('-') }
	before_save { self.skill_sub_dept = self.skill_sub_dept.downcase.split(' ').join('-') }
	
	has_attached_file :logo, styles: { medium: 'x60' }, default_url: '/images/:style/missing.png'

	has_many :object_skills

	def self.return_skill_hash_from_dept(dept_arr)
		return_hash = {}

		Skill.all.each do |skill_obj|
			return_hash[skill_obj.skill_sub_dept] ||= [] if dept_arr.include?(skill_obj.skill_dept)
			return_hash[skill_obj.skill_sub_dept] << skill_obj if dept_arr.include?(skill_obj.skill_dept)
		end

		# returns a hash where keys are sub_dept_name_string and value is an array of skill objects (of unique skill names)
		return_hash
	end

	def self.uniq_sub_depts(user_dept_arr)
		return_arr = []
		Skill.all.each do |skill|
			return_arr << skill.skill_sub_dept if user_dept_arr.include?(skill.skill_dept)
		end

		return_arr.uniq!
		return_arr
	end

	def self.return_skill_array(input_attr, input_attr_val, return_attr)
		# for example, send in 'skill_sub_dept', 'back-end', 'skill_name' to get an array of back-end skills
		skills = self.where("#{input_attr} = ?", input_attr_val)
		return_arr = skills.map do |skill|
			skill.public_send("#{return_attr}")
		end

		return_arr
	end

end
