class UserJobsController < ApplicationController
  
  respond_to :html, :json

  # RESTful Routes ---------------------------------------------------------------------------

  
  def create
    if params[:saved_job_id]
      UserJob.create(user_id: params[:user_id], saved_job_id: params[:saved_job_id])
    elsif params[:applied_job_id]
      UserJob.create(user_id: params[:user_id], applied_job_id: params[:applied_job_id])
    elsif params[:removed_job_id]
      UserJob.create(user_id: params[:user_id], removed_job_id: params[:removed_job_id])
    end
      
    redirect_to jobs_url
  end

  
end