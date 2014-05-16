class Admin::JobsController < Admin::ApplicationController

	def index
    @jobs = []
    jobs = Job.all.sample(10)

    jobs.each do |job|
      @job_ranker = JobRanker.new(job, current_user)
      @jobs << @job_ranker.job
    end

    @jobs.sort! { |a,b| b.job_score <=> a.job_score }  
   end
   
end