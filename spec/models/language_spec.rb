require 'rails_helper'

RSpec.describe Language, :type => :model do

  describe "validations" do
    it { is_expected.to ensure_length_of(:name).is_at_most(255) }
  end

  describe "create and update" do
    let(:user) { create(:user) }

    it "should be created from factories" do 
      expect(user.languages.count).to eq 2
    end

    context "updating list for user" do

      it "should be updated from given csv" do 
        user.update_list(Language, "a,b,c,d")
        expect(user.languages.count).to eq 4
        expect(user.languages).to include(Language.find_by_name(:a))
        expect(user.languages).to include(Language.find_by_name(:b))
        expect(user.languages).to include(Language.find_by_name(:c))
        expect(user.languages).to include(Language.find_by_name(:d))
      end      
    end

  end

end
