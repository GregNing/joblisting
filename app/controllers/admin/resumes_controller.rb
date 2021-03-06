class Admin::ResumesController < ApplicationController
    before_action :autherticate_user!
    before_action :require_is_admin
    layout 'admin'
    def index
        @job = Job.find(params[:id])
        @resumes = @job.resumes.order('created_at DESC')
    end
end
