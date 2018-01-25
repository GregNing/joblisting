class UserToResume < ActiveRecord::Migration[5.1]
  def change
    remove_column :resumes, :attachment
    remove_column :resumes, :name
    add_column  :resumes, :job_id, :integer 
    add_column  :resumes, :user_id, :integer 
    add_column  :resumes, :content, :text    
  end
end
