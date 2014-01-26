class SkillSet < ActiveRecord::Base
  belongs_to(
      :user
  )
  has_many(
      :additions,
      class_name: 'Addition',
      foreign_key: :skill_set_id
  )
  has_many :skills, :through => :additions
end
