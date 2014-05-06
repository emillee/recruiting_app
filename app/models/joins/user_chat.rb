class UserChat < ActiveRecord::Base

	belongs_to(
		:user_one,
		class_name: 'User',
		foreign_key: :user_one_id,
		primary_key: :id
	)

end