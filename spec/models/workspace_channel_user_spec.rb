require 'rails_helper'

RSpec.describe WorkspaceChannelUser, type: :model do
  subject(:workspace_channel_user) { build(:workspace_channel_user) }

  describe 'associations' do
    it { is_expected.to belong_to(:workspace_channel) }
    it { is_expected.to belong_to(:user) }
  end
end
