class Ceshi::JobsController < ApplicationController
  def index
    @jobs = Job.where(is_ceshi: true, is_hidden: false)
    case params[:order]
            when 'by_lower_bound'
              Job.where(is_hidden: false).order('wage_lower_bound DESC')
            when 'by_upper_bound'
              Job.where(is_hidden: false).order('wage_upper_bound DESC')
            else
              Job.where(is_hidden: false).order("created_at DESC")
            end
  end
  def show
    @job = Job.find(params[:id])
    @job.resumes = Resume.all
    if @job.is_hidden
      flash[:warning] = "you have no permission!"
      redirect_to ceshi_jobs_path
    end
  end
end
