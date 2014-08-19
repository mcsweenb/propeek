require 'rails_helper'

RSpec.describe User, :type => :model do
  
  describe "validations" do
    it { is_expected.to validate_presence_of :email }

    it { is_expected.to validate_presence_of :profession_name }
    it { is_expected.to ensure_length_of(:profession_name).is_at_most(64) }

    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to ensure_length_of(:linkedin_handle).is_at_least(5).is_at_most(30) }
    it { is_expected.to ensure_length_of(:twitter_handle).is_at_most(15) }
    it { is_expected.to ensure_length_of(:licensed_in).is_at_most(255) }

    it { is_expected.to ensure_length_of(:company_name).is_at_most(128) }
    it { is_expected.to ensure_length_of(:company_website).is_at_most(255 - "http://".length).with_message("is too long") }
    it { is_expected.to ensure_length_of(:job_title).is_at_most(128) }

    it { is_expected.to ensure_length_of(:phone_1).is_at_most(3) }
    it { is_expected.to ensure_length_of(:phone_2).is_at_most(3) }
    it { is_expected.to ensure_length_of(:phone_3).is_at_most(4) }

    it { is_expected.to ensure_length_of(:address_1).is_at_most(128) }
    it { is_expected.to ensure_length_of(:address_2).is_at_most(128) }
    it { is_expected.to ensure_length_of(:city).is_at_most(128) }    
    it { is_expected.to ensure_length_of(:state).is_at_most(64) }    
    it { is_expected.to ensure_length_of(:zip).is_at_most(32) }
  end

  describe "email uniqueness" do
    before { create(:user) }    
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  describe "handling company website" do
    it "should plug in the scheme" do 
      user = create(:user, company_website: "zuper.com")
      expect(user.company_website).to eq "http://zuper.com"
    end
  end

  describe "profession" do
    let!(:accountant) {create(:profession, :an_accountant)}
    let(:user) { create(:user, profession: accountant)}
    
    it "sets profession correctly" do 
      expect(user.profession_name).to eq "Accountant"
    end
  end

end
