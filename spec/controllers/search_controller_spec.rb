require 'rails_helper'

RSpec.describe SearchController, :type => :controller do

  setup :activate_authlogic

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', profession: "Accountant", speciality: "Personal", city: "New York"

      expect(response).to be_success
      expect(response).to render_template("search/index")
    end
  end

end
