require 'rails_helper'

RSpec.describe Experience, :type => :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :company_name }
    it { is_expected.to validate_presence_of :company_website }
    it { is_expected.to validate_presence_of :title }
    
    it { is_expected.to ensure_length_of(:company_name).is_at_most(255) }
    it { is_expected.to ensure_length_of(:company_website).is_at_most(255) }
    it { is_expected.to ensure_length_of(:title).is_at_most(255) }
    it { is_expected.to ensure_length_of(:description).is_at_most(255) }
  end
end
