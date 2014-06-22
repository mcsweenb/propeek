require 'rails_helper'

RSpec.describe Speciality, :type => :model do

  describe "memberships" do
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
