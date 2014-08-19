require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  setup :activate_authlogic

  describe "GET 'index'" do
    let!(:profession) { create(:profession) }
    let!(:specialities) { create_list(:speciality, 5, profession: profession) }

    it "returns http success" do
      get 'index'

      expect(response).to be_success
    end
  end

  describe "GET 'specialities'" do
    context "for a profession" do
      let!(:profession) { create(:profession) }
      let!(:specialities) { create_list(:speciality, 5, profession: profession) }

      it "renders specialities as json" do
        get :specialities, profession: profession.name
        expect(response).to be_success
        expect(json_response.size).to eq 5
      end

    end
    
  end

end
