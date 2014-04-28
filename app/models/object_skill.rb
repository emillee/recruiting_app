class ObjectSkill < ActiveRecord::Base
  
  validates :skill_id, presence: true
  
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
  	:company,
  	class_name: 'Company',
  	foreign_key: :company_id,
  	primary_key: :id
  )

  belongs_to(
    :skill, 
    class_name: 'Skill',
    foreign_key: :skill_id,
    primary_key: :id
  )

end