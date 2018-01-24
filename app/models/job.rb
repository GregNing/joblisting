class Job < ApplicationRecord
    belongs_to :user
    validates :title, :description,presence: true 
# validates_numericality_of :wage_upper_bound, :wage_lower_bound, :only_integer => true #必須是整數
# validates_email_format_of :email, :message => 'is not looking good'
# OR
validates :contact_email, :email_format => { :message => 'is not Contact Email' }    
    #必須是數字
    validates :wage_upper_bound, numericality: { greater_than: 0, :message => "必須為數字，且大於0"}
    validates :wage_lower_bound, numericality: { greater_than: 0, :message => "必須為數字，且大於0"}
    scope :recent, ->{ order("created_at DESC") }
    scope :whereis_hidden_is_false, -> { where(:is_hidden => false)}  

    def publish!
        self.is_hidden = false
        self.save
    end
    def hide!
        self.is_hidden = true
        self.save
    end
end
