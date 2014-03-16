class UserSkill < ActiveRecord::Base
  
  validates :user_id, presence: true
  validates :skill, presence: true
  
  belongs_to(
    :user,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

end