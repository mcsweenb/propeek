require 'rails_helper'

RSpec.describe Speciality, :type => :model do

  describe "validations" do
    it { is_expected.to ensure_length_of(:name).is_at_most(255) }
  end

  describe "create and update" do
    let(:user) { create(:user) }
    
    it "should be created from factories" do 
      expect(user.specialities.count).to eq 10
    end

    context "updating list for user" do

      it "should be updated from given csv" do 
        user.update_list(Speciality, "a,b,c,d")
        expect(user.specialities.count).to eq 4
        expect(user.specialities).to include(Speciality.find_by_name(:a))
        expect(user.specialities).to include(Speciality.find_by_name(:b))
        expect(user.specialities).to include(Speciality.find_by_name(:c))
        expect(user.specialities).to include(Speciality.find_by_name(:d))
      end      
    end

  end
end
