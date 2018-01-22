class JobController < ApplicationController
    # before_action :authenticate_user!, only: [:index]
    def index
    flash[:warning] = "Successfully created..."
    end
end
