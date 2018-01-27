class JobsController < ApplicationController
  before_action :authenticate_user!, only: %i[index destroy show new create update]
  before_action :find_jobs_id, only: %i[destroy show edit update]
  def index
    # @jobs = Job.whereis_hidden_is_false.recent.paginate(:page => params[:page], :per_page => 5)
    @jobs = case params[:order] # 傳送 order進來判斷是哪個參數
            when 'by_upper_bound'
              Job.whereis_hidden_is_false.recentwage_upper_bound.paginate(page: params[:page], per_page: 5)
            when 'by_lower_bound'
              Job.whereis_hidden_is_false.recentwage_lower_bound.paginate(page: params[:page], per_page: 5)
            else
              Job.whereis_hidden_is_false.recent.paginate(page: params[:page], per_page: 5)
            end
  end

  def new
    @jobs = Job.new
    # @resume = Resume.new
  end

  def create
    @jobs = Job.new(jobs_params)
    @jobs.user = current_user
    if @jobs.save
      redirect_to jobs_path, notice: "存擋成功#{@jobs.title}"
    else
      render :new
    end
  end

  def show
    if @jobs.is_hidden
      flash[:warning] = 'This Job already archived'
      redirect_to root_path
end
  end

  def edit; end

  def update
    if @jobs.update(jobs_params)
      redirect_to job_path(@jobs), notice: "#{@jobs.title}修改成功!"
    else
      render :edit
    end
  end

  def destroy
    @jobs.destroy
    redirect_to jobs_path, alert: "刪除成功#{@jobs.title}!"
  end

  private

  def find_jobs_id
    @jobs = Job.find(params[:id])
  end

  def jobs_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email)
  end
end
