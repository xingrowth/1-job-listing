class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_is_admin

  def index
    @jobs = Job.all
  end
  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.save
      redirect_to admin_jobs_path
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to admin_jobs_path, notice: "Update Success!"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to admin_jobs_path, alert: "Job deleted!"
  end

  def hide
    @job = Job.find(params[:id])
    @job.is_hidden = true;
    @job.save
    redirect_to admin_jobs_path
  end

  def public
    @job = Job.find(params[:id])
    @job.is_hidden = false;
    @job.save
    redirect_to admin_jobs_path
  end

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email)
  end
end
