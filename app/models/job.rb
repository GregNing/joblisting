# == Schema Information
#
# Table name: jobs
#
#  id               :integer          not null, primary key
#  title            :string
#  description      :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  wage_upper_bound :integer
#  wage_lower_bound :integer
#  contact_email    :string
#  is_hidden        :boolean          default(TRUE)
#  attachment       :text
#

class Job < ApplicationRecord
  belongs_to :user
  has_many :resumes
  validates :title, :description, presence: true
  # validates_numericality_of :wage_upper_bound, :wage_lower_bound, :only_integer => true #必須是整數
  # validates_email_format_of :email, :message => 'is not looking good'
  # OR
  validates :contact_email, email_format: { message: 'is not Contact Email' }
  # 必須是數字
  validates :wage_upper_bound, numericality: { greater_than: 0, message: '必須為數字，且大於0' }
  validates :wage_lower_bound, numericality: { greater_than: 0, message: '必須為數字，且大於0' }
  scope :recent, -> { order('created_at DESC') }
  scope :recentwage_upper_bound, -> { order('wage_upper_bound DESC') }
  scope :recentwage_lower_bound, -> { order('wage_lower_bound DESC') }
  scope :whereis_hidden_is_false, -> { where(is_hidden: false) }

  def publish!
    self.is_hidden = false
    save
  end

  def hide!
    self.is_hidden = true
    save
  end
end
