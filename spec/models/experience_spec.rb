require 'rails_helper'

RSpec.describe Experience, :type => :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :company_name }
    it { is_expected.to validate_presence_of :company_website }
    it { is_expected.to validate_presence_of :title }
    
    it { is_expected.to ensure_length_of(:company_name).is_at_most(255) }
    it { is_expected.to ensure_length_of(:company_website).is_at_most(255) }
    it { is_expected.to ensure_length_of(:title).is_at_most(255) }
    it { is_expected.to ensure_length_of(:description).is_at_most(255) }
  end

  describe "nested validations" do

    context "when creating experiences for an existing user" do 
      
      it "should create the experience" do
        user = create(:user)
        attrs = attributes_for(:experience, user_id: user.id, start_date: Date.today)

        user.update experiences_attributes: [attrs]

        expect(user.experiences(true).count).to eq 1
        expect(user.experiences.map(&:company_name)).to include(attrs[:company_name])
      end

      it "should run validations" do
        user = create(:user)
        attrs = attributes_for(:experience, user_id: user.id)

        user.update experiences_attributes: [attrs]
        
        expect(user.errors).to_not be_empty
        expect(user.errors).to include :"experiences.start_date"
      end
      
    end
    
  end

end
