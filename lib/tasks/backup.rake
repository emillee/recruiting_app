desc "PG Backup"
namespace :pg do
	task backup: [:environment] do
		# stamp the filename
		datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")

		# drop it in the db/backups directory temporarily
		backup_file = "#{Rails.root}/db/backups/db_name_#{datestamp}_dump.sql.gz"

		# dump the backup and zip it out
		sh "pg_dump -h localhost -U nytech nytech_development | gzip -c > #{backup_file}"

		send_to_amazon backup_file
	end
end