class Admin::JobsController < ApplicationController
  before_action :authenticate_user!, only: %i[index destroy show new create update publish hide]
  before_action :find_jobs_id, only: %i[destroy edit show update publish hide]
  before_action :require_is_admin
  layout 'admin'

  def index
    @jobs = Job.all.recent.paginate(page: params[:page], per_page: 5)
  end

  def new
    @jobs = Job.new
  end

  def create
    @jobs = Job.new(admin_jobs_params)
    @jobs.user = current_user
    if @jobs.save
      redirect_to admin_jobs_path, notice: "新增工作機會#{@jobs.title}成功!"
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @jobs.update(admin_jobs_params)
      redirect_to job_path(@jobs), notice: "#{@jobs.title}修改成功!"
    else
      render :edit
    end
  end

  def destroy
    @jobs.destroy
    redirect_to jobs_path, alert: "刪除成功#{@jobs.title}!"
  end

  def publish
    @jobs.publish!
    # redirect_to admin_jobs_path, :notice => "#{@jobs.title}顯示成功"
    redirect_to :back
  end

  def hide
    @jobs.hide!
    redirect_to admin_jobs_path, notice: "#{@jobs.title}隱藏成功"
  end

  private

  def find_jobs_id
    @jobs = Job.find(params[:id])
  end

  def admin_jobs_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email, :is_hidden)
  end
end
