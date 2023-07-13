require 'rails_helper'

RSpec.describe Message, type: :model do
  subject(:message) { build(:message) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:classifiable) }
    it { is_expected.to belong_to(:author) }
    it { is_expected.to belong_to(:responded_message).optional }
    it { is_expected.to have_many(:responded_messages) }
  end
end
