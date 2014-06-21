require 'rails_helper'

RSpec.describe Membership, :type => :model do

  describe "memberships" do
    let(:user) { create(:user, memberships_count: 5) }
    it "should be created from factories" do 
      expect(user.memberships.count).to eq 5
    end
  end

end
