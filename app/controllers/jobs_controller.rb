<<<<<<< HEAD
class JobsController < ApplicationController 
  
  def index
    @jobs = Job.all
  end
  
end
=======
class JobsController < ApplicationController
  
  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new(job_params)
    
    if @job.save
      flash[:success] = "Job saved successfully"
      redirect_to(@job)
    else
      flash[:error] = "Please try again"
      render :new
    end
  end
  
  def show 
    @job = Job.find(params[:id])
  end
  
  def index
    @job = Job.all
  end
  
end
>>>>>>> Jobs
