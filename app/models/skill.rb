class Skill < ActiveRecord::Base
  has_many(
    :additions,
    class_name: 'Addition',
    foreign_key: :skill_id
  )
  has_many :skillsets, :through => :additions
end

