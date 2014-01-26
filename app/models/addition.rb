class Addition < ActiveRecord::Base
  belongs_to(
      :skill_set,
      class_name: 'SkillSet',
      foreign_key: :skill_set_id,
      primary_key: :id
  )
  belongs_to(
      :skill,
      class_name: 'Skill',
      foreign_key: :skill_id,
      primary_key: :id
  )
end
