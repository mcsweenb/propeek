require 'rails_helper'

RSpec.describe Speciality, :type => :model do
  describe "memberships" do
    let(:user) { create(:user) }
    it "should be created from factories" do 
      expect(user.specialities.count).to eq 10
    end
  end
end
