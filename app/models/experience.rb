class Experience < ActiveRecord::Base

  validates :company_name, presence: true, length: {maximum: 255}
  validates :company_website, presence: true, length: {maximum: 255}
  validates :title, presence: true, length: {maximum: 255}
  validates :start_date, presence: true
  validates :description, length: {maximum: 255, allow_nil: true}
  
  belongs_to :user, inverse_of: :experiences
  validates_presence_of :user

end
