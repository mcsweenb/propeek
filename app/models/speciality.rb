class Speciality < ActiveRecord::Base

  validates :name, length: {maximum: 255}

  validates :profession, presence: true

  has_and_belongs_to_many :users

  belongs_to :profession, inverse_of: :specialities

end
