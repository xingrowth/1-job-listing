class JobsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :update, :edit, :destroy]

  def index
    @jobs = case params[:order]
      when 'by_lower_bound'
        Job.where(is_hidden: false).order('wage_lower_bound DESC')
      when 'by_upper_bound'
        Job.where(is_hidden: false).order('wage_upper_bound DESC')
      else
        Job.where(:is_hidden => false).order("created_at DESC")
      end
  end

  def show
    @job = Job.find(params[:id])
    @resumes = @job.resumes

    if @job.is_hidden
      flash[:warning] = "This job already archieved"
      redirect_to root_path
    end
  end

  def new
    @job = Job.new
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

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to admin_jobs_path,notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    #[:alert] = "Job deleted"
    redirect_to jobs_path, alert: "Job deleted"
  end

  def search
    q = params[:q]
    @jobs = Job.search(title: q)
  end

  private



  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound,
                                    :contact_mail, :is_hidden)
  end

end
