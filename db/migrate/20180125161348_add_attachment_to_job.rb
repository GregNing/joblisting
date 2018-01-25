class AddAttachmentToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :attachment,:text
  end
end
