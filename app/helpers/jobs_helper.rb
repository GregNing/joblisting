module JobsHelper
    def render_jobs_description(jobs)
        simple_format(jobs.description)
    end     
end
