class Admin::JobsController < ApplicationController
  before_action :authenticate_user!
  before_filter :require_is_admin
  def index
    @jobs = Job.all.recent
  end
  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
     redirect_to admin_jobs_path, notice: 'Update Success!'
   else
     render :edit
   end
  end

  def destroy
    @job = Job.find(params[:id])
    if @job.delete
      redirect_to admin_jobs_path, alert: 'Job Deleted!'
    end
  end

  def show
    @job = Job.find(params[:id])
  end


private
def job_params
  params.require(:job).permit(:title, :description)
end
def require_is_admin
  if !current_user.admin?
    redirect_to root_path, alert: 'You are not admin!'
  end
end
end
