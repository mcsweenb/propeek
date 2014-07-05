require 'rails_helper'

RSpec.describe Review, :type => :model do

  describe "validations" do
    it { is_expected.to validate_presence_of :review_for }
    it { is_expected.to validate_numericality_of(:rating).only_integer }
    it { is_expected.to validate_numericality_of(:rating).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:rating).is_less_than_or_equal_to(5) }    
  end

  context "receiving reviews" do 
    let!(:receiver) { create(:user) }

    context "from a registered user" do
      let!(:giver) { create(:user) }

      it "should create the review" do 
      
        receiver.reviews_received.create(rating: 5, review_by: giver, review: "a test review")
        
        expect(receiver.reviews_received.count).to eq(1)
        expect(giver.reviews_given.count).to eq(1)
        
        expect(receiver.reviews_received.map(&:review)).to include("a test review")
        expect(giver.reviews_given.map(&:review)).to include("a test review")
        
        expect(receiver.reviews_received.map(&:rating)).to include(5)
        expect(giver.reviews_given.map(&:rating)).to include(5)
      end
    end

    context "from an anonymous user" do
      let!(:giver) { create(:user) }

      it "should create the review" do       
        receiver.reviews_received.create(rating: 5, review: "a test review")
        
        expect(receiver.reviews_received.count).to eq(1)
        
        expect(receiver.reviews_received.map(&:review)).to include("a test review")
        
        expect(receiver.reviews_received.map(&:rating)).to include(5)

        expect(receiver.reviews_received.map(&:review_by)).to include(nil)
      end
    end


  end

end
