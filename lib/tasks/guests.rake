namespace :guest_users do 

	desc "Remove guest users more than a month old"
	task :cleanup => :environment do
		User.where(is_guest: :true).where('updated_at < ?', 4.weeks.ago).destroy_all
	end

end