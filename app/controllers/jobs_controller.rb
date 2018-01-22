class JobsController < ApplicationController
    before_action :authenticate_user!, only: [:index,:destroy, :show,:new ,:create]
    before_action :find_jobs_id, only: [:destroy, :show, :edit]
    def index
        @jobs = Job.all
    end

    def new
        @jobs = Job.new
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
        
    end

    def edit
        
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
        params.require(:job).permit(:title, :description)
    end
end
