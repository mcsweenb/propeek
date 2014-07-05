require 'rails_helper'

RSpec.describe Review, :type => :model do

  describe "validations" do
    it { is_expected.to validate_presence_of :review_for }
    it { is_expected.to validate_numericality_of(:rating).only_integer }
    it { is_expected.to validate_numericality_of(:rating).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:rating).is_less_than_or_equal_to(5) }    
  end

end
