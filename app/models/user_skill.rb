class UserSkill < ActiveRecord::Base
  
  validates :user_id, presence: true
  validates :skill, presence: true
  validates :level, presence: true
end