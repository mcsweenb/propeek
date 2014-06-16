require 'rails_helper'

RSpec.describe RegisterController, :type => :controller do

  describe "GET 'step1'" do
    it "returns http success" do
      get 'step1'

      expect(response).to be_success
      expect(response).to render_template(:step1)

      assert_select("form#register_step1") do
        assert_select("input[name=email]")
        assert_select("input[name=firstname]")
        assert_select("input[name=lastname]")
        assert_select("input[name=password]")
        assert_select("input[name=confirm_password]")
      end
    end
  end

  describe "GET 'step2'" do
    it "returns http success" do
      get 'step2'
      expect(response).to be_success
    end
  end

  describe "GET 'step3'" do
    it "returns http success" do
      get 'step3'
      expect(response).to be_success
    end
  end

  describe "GET 'step4'" do
    it "returns http success" do
      get 'step4'
      expect(response).to be_success
    end
  end

end
