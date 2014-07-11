require 'rails_helper'

RSpec.describe ProfileController, :type => :controller do

  setup :activate_authlogic

  describe "GET 'show'" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      UserSession.create(user)
      
      get 'show', user_id: user.id

      expect(response).to be_success
      expect(response).to render_template("show")
    end
  end

  describe "GET 'login'" do
    it "returns http success" do
      get 'login'

      expect(response).to be_success
      expect(response).to render_template("login")

      assert_select "form.login_form" do
        assert_select "input[name=?]", "user_session[email]"
        assert_select "input[name=?]", "user_session[password]"
      end
    end
  end
   
  describe "login submission" do 
    
    context "with incorrect credentials" do
      let(:user) {create(:user)}
    
      it "should fail to login" do
        post 'login', user_session: {}
        
        expect(response).to be_success
        expect(response).to render_template("login")
      end

      it "should fail to login" do
        post 'login', user_session: {email: user.email, password: 'rubbish'}
        
        expect(response).to be_success
        expect(response).to render_template("login")
      end
    end

    context "with correct credentials" do
      let(:user) {create(:user, password: 'goodpass', password_confirmation: 'goodpass')}

      it "should login and show profile" do
        post 'login', user_session: {email: user.email, password: 'goodpass'}        

        expect(response).to redirect_to(register_url)
      end
    end
  end

  describe "login and wizard workflow" do
    context "with step 1 completed" do
      let(:user) {create(:user, password: 'goodpass', password_confirmation: 'goodpass', registration_step_number: 1)}
      context "login" do
        it "should go to step 2" do
          post 'login', user_session: {email: user.email, password: 'goodpass'}        
          
          expect(response).to redirect_to(register2_url)
        end
      end
      context "private profile goes to" do        
        it "should go to step 2" do
          UserSession.create(user)
          get :private
          expect(response).to redirect_to(register2_url)
        end
      end
    end

    context "with step 2 completed" do
      let(:user) {create(:user, password: 'goodpass', password_confirmation: 'goodpass', registration_step_number: 2)}
      context "login" do
        it "should go to step 3" do
          post 'login', user_session: {email: user.email, password: 'goodpass'}        
          
          expect(response).to redirect_to(register3_url)
        end
      end
      context "private profile goes to" do        
        it "should go to step 3" do
          UserSession.create(user)
          get :private
          expect(response).to redirect_to(register3_url)
        end
      end
    end

    context "with step 3 completed" do
      let(:user) {create(:user, password: 'goodpass', password_confirmation: 'goodpass', registration_step_number: 3)}
      context "login" do
        it "should go to private profile" do
          post 'login', user_session: {email: user.email, password: 'goodpass'}        
          
          expect(response).to redirect_to(profile_private_url)
        end
      end
      context "private profile goes to" do        
        it "should go to step 3" do
          UserSession.create(user)
          get :private
          expect(response).to redirect_to(profile_private_url)
        end
      end
    end


  end

end

