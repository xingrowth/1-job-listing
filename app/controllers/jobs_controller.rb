class JobsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def show
    @job = Job.find(params[:id])
  end

  def edit
    @job = Job.find(params[:id])
    if current_user != @job.user
      redirect_to root_path, alert: "Your have no permission."
    end
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user

    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])

    if current_user != @job.user
      redirect_to root_path, alert: "Your have no permission."
    end

    if @job.update(job_params)
      redirect_to jobs_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])

    if current_user != @job.user
      redirect_to root_path, alert: "Your have no permission."
    end

    @job.destroy
    redirect_to jobs_path, alert: "Job deleted"
  end

  private

  def job_params
    params.require(:job).permit(:title, :description)
  end


    def require_is_admin
      if !current_user.admin?
        flash[:alert] = 'Your are not admin'
        redirect_to root_path
      end
    end


end
