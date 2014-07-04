class Education < ActiveRecord::Base

  validates :qualification, presence: true, length: {maximum: 255}
  validates :institution, presence: true, length: {maximum: 255}
  validates :start_date, presence: true
  validates :end_date, presence: true, allow_nil: true
  validates :description, length: {maximum: 255, allow_nil: true}

  belongs_to :user, inverse_of: :educations
  validates_presence_of :user

end
