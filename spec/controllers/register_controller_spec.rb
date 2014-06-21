require 'rails_helper'

RSpec.describe RegisterController, :type => :controller do

  setup :activate_authlogic

  describe "GET 'step1'" do
    it "returns http success" do
      get 'step1'

      expect(response).to be_success
      expect(response).to render_template(:step1)

      assert_select "form.register_form" do
        assert_select "input[name=?]", "user[email]"
        assert_select "input[name=?]", "user[first_name]"
        assert_select "input[name=?]", "user[last_name]"
        assert_select "input[name=?]", "user[password]"
        assert_select "input[name=?]", "user[password_confirmation]"
      end
    end

    context "Submit step 1 with missing fields" do 

      it "returns http success " do
        post 'step1', user: {}

        expect(response).to be_success
        expect(response).to render_template(:step1)
        assert_select "div.error span", 5
      end

      it "returns http success " do
        post 'step1', user: {email: "abcd@example.com"}

        expect(response).to be_success
        expect(response).to render_template(:step1)
        assert_select "div.error span", 4
      end

    end

    context "Submit step 1 with all valid data" do 
      it "returns http success " do
        user_attributes = attributes_for(:user)
        post 'step1', user: user_attributes

        user = assigns(:user)
        puts user.errors.full_messages
        expect(user.email).to match user_attributes[:email]
        expect(user.registration_step_number).to eq(1)

        expect(response).to be_success
        expect(response).to render_template(:step2)
      end
    end

    context "Already logged in user" do 
      describe "accessing step1" do
        it "should take user to step2" do
          user = FactoryGirl.create(:user, registration_step_number: 1)
          UserSession.create(user)

          get 'step1'

          expect(response).to redirect_to(register2_url)
        end
      end
    end

  end

  describe "GET 'step2'" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      UserSession.create(user)

      get 'step2'

      expect(response).to be_success
    end
  end

  describe "GET 'step3'" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      UserSession.create(user)

      get 'step3'

      expect(response).to be_success
    end
  end

  describe "GET 'step4'" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      UserSession.create(user)

      get 'step4'

      expect(response).to be_success
    end
  end

end
