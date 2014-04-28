class ObjectSkill < ActiveRecord::Base
  
  validates :skill_id, presence: true
  
  belongs_to :user
  belongs_to :company
  belongs_to :skill 

end