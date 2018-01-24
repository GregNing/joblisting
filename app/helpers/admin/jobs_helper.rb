module Admin::JobsHelper
    def render_jobs_description(jobs)
        simple_format(jobs.description)
    end    

    def render_jobs_status(job)
        if job.is_hidden?
            content_tag(:span, "", :class => "fa fa-lock")
        else
            content_tag(:span, "", :class => "fa fa-globe")
        end        
    end    
end
