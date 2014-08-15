class Profession < ActiveRecord::Base
  
  has_many :users, foreign_key: :profession_name, primary_key: :name, inverse_of: :profession

end
