# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Nytech::Application.load_tasks

def send_to_amazon(file_path)
	bucket_name = ENV['S3_BUCKET_NAME']
	key = File.basename(file_path)

	s3 = AWS::S3.new(
		access_key_id: ENV['AWS_ACCESS_KEY'],
		secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
	)

	s3.buckets[bucket_name].objects[key].write(file: File.open("#{file_path}"))
end
