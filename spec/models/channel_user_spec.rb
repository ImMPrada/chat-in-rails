require 'rails_helper'

RSpec.describe ChannelUser, type: :model do
  subject(:channel_user) { build(:channel_user) }

  describe 'associations' do
    it { is_expected.to belong_to(:channel) }
    it { is_expected.to belong_to(:user) }
  end
end
