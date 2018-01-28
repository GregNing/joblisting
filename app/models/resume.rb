# == Schema Information
#
# Table name: resumes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  job_id     :integer
#  user_id    :integer
#  content    :text
#  attachment :string
#

class Resume < ApplicationRecord
  belongs_to :user
  belongs_to :job
  mount_uploader :attachment, AttachmentUploader
  validates :content, presence: true
end
