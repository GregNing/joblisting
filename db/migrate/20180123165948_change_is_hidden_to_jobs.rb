class ChangeIsHiddenToJobs < ActiveRecord::Migration[5.1]
  def change
    change_column :jobs, :is_hidden, :boolean, default: true
  end
end
