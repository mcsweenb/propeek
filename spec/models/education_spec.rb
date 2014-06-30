require 'rails_helper'

RSpec.describe Education, :type => :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :qualification }
    it { is_expected.to validate_presence_of :institution }
    it { is_expected.to validate_presence_of :start_date }

    it { is_expected.to ensure_length_of(:qualification).is_at_most(255) }
    it { is_expected.to ensure_length_of(:institution).is_at_most(255) }
    it { is_expected.to ensure_length_of(:description).is_at_most(255) }
  end

  describe "nested validations" do

    context "when creating experiences for an existing user" do 
      
      it "should create the education" do
        user = create(:user)
        attrs = attributes_for(:education, user_id: user.id, start_date: Date.today)

        user.update educations_attributes: [attrs]

        expect(user.educations.count).to eq 1
        expect(user.educations.map(&:qualification)).to include(attrs[:qualification])
      end

      it "should run validations" do
        user = create(:user)
        attrs = attributes_for(:education, user_id: user.id)

        user.update educations_attributes: [attrs]
        
        expect(user.errors).to_not be_empty
        expect(user.errors).to include :"educations.start_date"
      end
      
    end
    
  end

end
