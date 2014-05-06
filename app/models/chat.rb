class Chat < ActiveRecord::Base

	belongs_to :user

	# has_many(
	# 	:user_one_chats, 
	# 	class_name: 'UserChat',
	# 	foreign_key: :user_id_one,
	# 	primary_key: :id
	# )

	# has_many :users, through: :user_one_chats, source: :user_one


end