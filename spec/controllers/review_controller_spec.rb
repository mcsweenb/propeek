require 'rails_helper'

RSpec.describe ProfileController, :type => :controller do

  setup :activate_authlogic

  describe "creating reviews" do

    context "submitting blank form" do 
      context "with bad user specified" do
        it "should not create a review" do
          post :create_review, {for_user_id: 100}
          
          expect(response).to redirect_to(root_url)
          expect(flash[:notice]).to eq("Bad request. No profile selected.")
        end              
      end
    end

    context "submitting incorrect form" do 
      context "with no content" do
        let!(:user) { create(:user) }
        it "should show error" do
          post :create_review, {for_user_id: user.id}

          expect(response).to redirect_to(profile_url(user))
          expect(flash[:notice]).to include("Rating is not a number")
          expect(assigns[:review].review).to be_nil
          expect(assigns[:review].rating).to be_nil
        end      
      end

      context "with nil values" do
        let!(:user) { create(:user) }
        it "should show error" do
          post :create_review, {for_user_id: user.id, score: nil, review: nil}
          
          expect(response).to redirect_to(profile_url(user))
          expect(flash[:notice]).to include("Rating is not a number")
          expect(assigns[:review].review).to be_nil
          expect(assigns[:review].rating).to be_nil
        end      
      end
    end

    context "submitting valid form" do 
      context "by anonymous user" do 
        let!(:user) { create(:user) }
        it "should create a review" do
          UserSession.find.destroy
          post :create_review, {for_user_id: user.id, score: 1, review: "a test review"}

          expect(response).to redirect_to(profile_url(user))
          expect(flash[:notice]).to include("Review saved")
          expect(assigns[:review].rating).to eq 1
          expect(assigns[:review].review_by).to be_nil
        end      
      end

      context "by registered logged in user" do 
        let!(:user) { create(:user) }
        let!(:review_by_user) { create(:user) }
        it "should create a review" do
          UserSession.create review_by_user
          post :create_review, {for_user_id: user.id, score: 1, review: "a test review"}
          
          expect(response).to redirect_to(profile_url(user))
          expect(flash[:notice]).to include("Review saved")
          expect(assigns[:review].review).to eq "a test review"
          expect(assigns[:review].rating).to eq 1
          expect(assigns[:review].review_by).to eq review_by_user
        end      
      end
    end

  end

end
