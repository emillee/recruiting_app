namespace :jobs_rake do

	desc "identify jobs that have already expired"

def remote_file_exists?(url)
  url = URI.parse(url)
  Net::HTTP.start(url.host, url.port) do |http|
    return http.head(url.request_uri).code == "200" rescue false
  end
end

	task :identify_expired_jobs do
		expired_jobs = []

		Job.all.each do |job|
			expired_jobs << job if remote_file_exists?(job.link) == false
		end

		expired_jobs.each do |expired_job|
			p expired_job.link
		end
	end

end