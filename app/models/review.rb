class Review < ActiveRecord::Base

  validates_presence_of :review_for  
  validates :review, length: {
    maximum: 255, 
    allow_nil: true
  }
  validates :rating, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0, 
    less_than_or_equal_to: 5
  }

  belongs_to :review_for, foreign_key: :review_for_id, class_name: 'User'
  belongs_to :review_by, foreign_key: :review_by_id, class_name: 'User'

  def reviewer_name
    review_by.blank? ? "Anonymous reviewer" : review_by.fullname
  end

end
