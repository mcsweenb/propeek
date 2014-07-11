require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  setup :activate_authlogic

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

end
