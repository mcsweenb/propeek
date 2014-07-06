require 'rails_helper'

RSpec.describe Review, :type => :model do

  describe "validations" do
    it { is_expected.to validate_presence_of :review_for }
    it { is_expected.to validate_numericality_of(:rating).only_integer }
    it { is_expected.to validate_numericality_of(:rating).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:rating).is_less_than_or_equal_to(5) }    
  end

  describe "receiving reviews" do 
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

  describe "reviews breakdown" do    
    context "for a user" do      
      let!(:user) { create(:user) }
        
      it "should show correct review breakdown" do
        10.times do |i|
          user.reviews_received.create(rating: i % 5 + 1, review: "a sample review")
        end
        breakdown = user.review_breakdown
        
        expect(breakdown).to include([1, 2, 20])
        expect(breakdown).to include([2, 2, 20])
        expect(breakdown).to include([3, 2, 20])
        expect(breakdown).to include([4, 2, 20])
        expect(breakdown).to include([5, 2, 20])
      end
    end    
  end

end
