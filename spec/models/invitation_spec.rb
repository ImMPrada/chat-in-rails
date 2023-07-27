require 'rails_helper'

RSpec.describe Invitation, type: :model do
  subject(:invitation) { build(:invitation) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:token) }
    it { is_expected.to validate_uniqueness_of(:token) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:workspace) }
    it { is_expected.to belong_to(:receiver).class_name('User').optional }
  end
end
