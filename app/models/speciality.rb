class Speciality < ActiveRecord::Base

  validates :name, length: {maximum: 255}

  has_and_belongs_to_many :users

end
