require 'rails_helper'

RSpec.describe WorkspaceUser, type: :model do
  subject(:workspace_user) { build(:workspace_user) }

  describe 'associations' do
    it { is_expected.to belong_to(:workspace) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:role) }
  end
end
