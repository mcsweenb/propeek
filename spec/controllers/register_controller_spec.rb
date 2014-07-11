require 'rails_helper'

RSpec.describe RegisterController, :type => :controller do

  setup :activate_authlogic

  describe "'step1'" do
    it "GET returns http success" do
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

      it "should return with errors " do
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
      it "should update user and create associations " do
        user_attributes = attributes_for(:user)
        post 'step1', user: user_attributes

        user = assigns(:user)
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

  describe "'step2'" do
    it "GET returns http success" do
      user = FactoryGirl.create(:user)
      UserSession.create(user)

      get 'step2'

      expect(response).to be_success
      expect(response).to render_template(:step2)
    end

    context "Submit step 2 with missing fields" do 

      it "should leave user unchanged" do
        user = FactoryGirl.create(:user)
        UserSession.create(user)

        post 'step2', user: {}

        user = assigns(:user)
        expect(user.registration_step_number).to eq(2)

        expect(response).to be_success
        expect(response).to render_template(:step3)
      end
    end

    context "Submit step 2 with new invalid data" do 
      it "should return with errors " do
        user = FactoryGirl.create(:user, registration_step_number: 1)
        UserSession.create(user)

        post 'step2', user: {company_name: "a"*256, company_website: "w"*256, job_title: "j"*256,
          bio: "a"*256, specialities: "s1,#{'s2'*256},s3", memberships: "m1,#{'m2'*256},m3",
          phone_1: "11111", phone_2: "11111", phone_3: "11111",
          address_1: "a"*256, address_2: "a"*256, city: "a"*256,
          state: "s"*256, zip: "z"*256}

        user = assigns(:user)
        expect(user.registration_step_number).to eq(1)

        expect(response).to be_success
        expect(response).to render_template(:step2)
        expect(user.errors.size).to eq 12
        assert_select "div.error span", 12
      end
    end


    context "Submit step 2 with new invalid data" do 
      it "should return with errors " do
        user = FactoryGirl.create(:user, registration_step_number: 1)
        UserSession.create(user)

        post 'step2', user: {company_name: "Jackals", company_website: "jackals.com", job_title: "chief jackal",
          bio: "test bio", specialities: "s1,#{'s2'*256},s3", memberships: "m1,#{'m2'*256},m3"}

        user = assigns(:user)
        expect(user.registration_step_number).to eq(1)

        expect(response).to be_success
        expect(response).to render_template(:step2)
        expect(user.errors.size).to eq 2
        assert_select "div.error span", 2
      end
    end

    context "Submit step 2 with new valid data" do 
      it "should update user fields and associations " do
        user = FactoryGirl.create(:user)
        UserSession.create(user)

        post 'step2', user: {company_name: "Jackals", company_website: "jackals.com", job_title: "chief jackal",
          bio: "test bio", specialities: "s1,s2,s3", memberships: "m1,m2,m3",
          address_1: "address 1", adderss_2: nil, city: "random", state: "blasted", zip: "232332",
          phone_1: "111", phone_2: "222", phone_3: "1234"}

        user = assigns(:user)
        expect(user.registration_step_number).to eq(2)

        expect(user.company_name).to match(/Jackals/)
        expect(user.bio).to match(/test bio/)

        expect(user.specialities.count).to eq(3)
        expect(user.specialities).to include(Speciality.find_by_name(:s1))
        expect(user.specialities).to include(Speciality.find_by_name(:s2))
        expect(user.specialities).to include(Speciality.find_by_name(:s3))

        expect(user.memberships.count).to eq(3)
        expect(user.memberships).to include(Membership.find_by_name(:m1))
        expect(user.memberships).to include(Membership.find_by_name(:m2))
        expect(user.memberships).to include(Membership.find_by_name(:m3))

        expect(user.lonlat).to_not be_nil

        expect(response).to be_success
        expect(response).to render_template(:step3)
      end

      it "should not gecode an address " do
        user = FactoryGirl.create(:user)
        UserSession.create(user)

        post 'step2', user: {company_name: "Jackals", company_website: "jackals.com", job_title: "chief jackal",
          bio: "test bio", specialities: "s1,s2,s3", memberships: "m1,m2,m3",
          address_1: "", adderss_2: "", city: "", state: "", zip: "",
          phone_1: "111", phone_2: "222", phone_3: "1234"}

        user = assigns(:user)

        expect(user.lonlat).to be_nil

        expect(response).to be_success
        expect(response).to render_template(:step3)
      end

    end
  end

  describe "'step3'" do
    context "GET" do 
      it "should return http success" do
        user = FactoryGirl.create(:user)
        UserSession.create(user)        

        get 'step3'

        expect(response).to be_success
        assert_select "form.register_form" do
          assert_select "input[name=?]", "user[min_hourly]"
          assert_select "input[name=?]", "user[max_hourly]"
          assert_select "textarea[name=?]", "user[fee_notes]"
        end
      end
    end

    context "Submit step 3 with missing fields" do 

      it "should leave user unchanged" do
        user = FactoryGirl.create(:user)
        UserSession.create(user)

        post 'step3', user: {}

        user = assigns(:user)
        expect(user.registration_step_number).to eq(3)

        expect(response).to redirect_to(profile_private_url)
      end
    end

    context "Submit step 3 with new invalid data" do 
      it "should return with errors " do
        user = FactoryGirl.create(:user, registration_step_number: 2)
        UserSession.create(user)

        post 'step3', user: {min_hourly: :x, max_hourly: :y, fee_notes: "a"*256}

        user = assigns(:user)
        expect(user.registration_step_number).to eq(2)

        expect(response).to be_success
        expect(response).to render_template(:step3)
        expect(user.errors.size).to eq 3
      end
    end


    context "Submit step 3 with new valid data" do 
      it "should update user fields and associations " do
        user = FactoryGirl.create(:user)
        UserSession.create(user)

        post 'step3', user: {min_hourly: 100, max_hourly: 200, fee_notes: "test note"}

        user = assigns(:user)
        expect(user.registration_step_number).to eq(3)

        expect(user.errors.size).to eq 0
        assert_select "div.error span", 0

        expect(response).to redirect_to(profile_private_url)
        
        expect(assigns[:user].min_hourly_cents).to eq(100 * 100)
        expect(assigns[:user].max_hourly_cents).to eq(200 * 100)
        expect(assigns[:user].fee_notes).to eq "test note"
      end
    end
  end
end
