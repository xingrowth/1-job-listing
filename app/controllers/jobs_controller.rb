class JobsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :edit, :create, :update, :destroy]
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
  end
  def create
    @job = Job.new(job_params)
    if @job.save
    redirect_to root_path
  else
    render :new
  end
  end
  def update
    @job = Job.find(params[:id])
    if @job.updata(job_params)
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
  def job_params
    params.require(:job).permit(:title, :description)
  end
end
