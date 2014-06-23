require 'rails_helper'

RSpec.describe User, :type => :model do
  
  describe "validations" do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to ensure_length_of(:linkedin_handle).is_at_least(5).is_at_most(30) }
    it { is_expected.to ensure_length_of(:twitter_handle).is_at_most(15) }
    it { is_expected.to ensure_length_of(:licensed_in).is_at_most(255) }
  end

  describe "email uniqueness" do
    before { create(:user) }    
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

end
