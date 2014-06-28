require 'rails_helper'

RSpec.describe Education, :type => :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :qualification }
    it { is_expected.to validate_presence_of :institution }
    it { is_expected.to validate_presence_of :start_date }

    it { is_expected.to ensure_length_of(:qualification).is_at_most(255) }
    it { is_expected.to ensure_length_of(:institution).is_at_most(255) }
    it { is_expected.to ensure_length_of(:description).is_at_most(255) }
  end
end
