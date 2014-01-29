class Admin::JobsController < Admin::ApplicationController

  def index
    if current_user && !current_user.job_settings.blank?
      @jobs = Job.search(current_user.job_settings)
    else
      @jobs = Job.all
    end
  end

end