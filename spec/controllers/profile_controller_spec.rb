require 'rails_helper'

RSpec.describe ProfileController, :type => :controller do

  setup :activate_authlogic

  describe "GET 'show'" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      session = UserSession.create(user)

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

end

