class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :update, :create, :edit, :destroy]
  def show
    @job = Job.find(params[:id])
  end

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_parames)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_parames)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to root_path
  end

private
  def job_parames
    params.require(:job).permit(:title, :descripiton)
  end

end
