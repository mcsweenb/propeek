require 'rails_helper'

RSpec.describe SearchController, :type => :controller do

  setup :activate_authlogic

  describe "GET 'index'" do
    let!(:profession) { FactoryGirl.create :profession }
    let(:speciality) {FactoryGirl.create :speciality, profession: profession }

    it "returns http success" do
      get 'index', profession: profession.name, speciality: speciality.name, city: "New York"

      expect(response).to be_success
      expect(response).to render_template("search/index")
    end
  end

  context "JSON search" do
    let!(:profession1) { create(:profession) }
    let!(:profession2) { create(:profession) }
    let!(:speciality1) { create(:speciality, profession: profession1) }
    let!(:speciality2) { create(:speciality, profession: profession1) }
    let!(:city) { "New York" }

    let(:user1) { create :user, profession: profession1, city: city }
    let(:user2) { create :user, profession: profession2, city: city }

    context "with given profession" do       
      it "should return all users for that profession" do
        user1.specialities << [speciality1, speciality2]
        
        request.accept = "application/json"
        xhr :get, :index, profession: profession1.name, city: city

        expect(json_response.users.size).to eq 1
      end      
    end

    context "with given profession and speciality" do
      it "should return all users for that profession and speciality" do
        user1.specialities << [speciality1]

        request.accept = "application/json"
        xhr :get, :index, profession: profession1.name, speciality: speciality1.name, city: city

        expect(json_response.users.size).to eq 1
      end      
    end


  end

end
