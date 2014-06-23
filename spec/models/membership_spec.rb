require 'rails_helper'

RSpec.describe Membership, :type => :model do

  describe "validations" do
    it { is_expected.to ensure_length_of(:name).is_at_most(255) }
  end

  describe "create and update" do
    let(:user) { create(:user, memberships_count: 5) }

    it "should be created from factories" do 
      expect(user.memberships.count).to eq 5
    end

    context "updating list for user" do

      it "should be updated from given csv" do 
        user.update_list(Membership, "a,b,c,d")
        expect(user.memberships.count).to eq 4
        expect(user.memberships).to include(Membership.find_by_name(:a))
        expect(user.memberships).to include(Membership.find_by_name(:b))
        expect(user.memberships).to include(Membership.find_by_name(:c))
        expect(user.memberships).to include(Membership.find_by_name(:d))
      end      

    end

  end

end
