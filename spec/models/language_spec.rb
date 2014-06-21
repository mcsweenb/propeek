require 'rails_helper'

RSpec.describe Language, :type => :model do

  describe "languages" do
    let(:user) { create(:user) }
    it "should be created from factories" do 
      expect(user.languages.count).to eq 2
    end
  end

end
