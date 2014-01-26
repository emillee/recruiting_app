class SkillSet < ActiveRecord::Base
  belongs_to(
      :users,
      class_name: 'User',
      foreign_key: :user_id,
      primary_key: :id
  )
  has_many(
      :additions,
      class_name: 'Addition',
      foreign_key: :skill_set_id,
      primary_key: id
  )
  has_many :skills, :through => :additions
end
