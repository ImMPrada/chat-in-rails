require 'rails_helper'

RSpec.describe Channels::Updater do
  subject(:updater) { described_class.new(params, current_user, channel) }

  let(:current_user) { create(:user) }
  let(:workspace) { create(:workspace) }
  let(:channel) { create(:channel, workspace:) }

  before do
    role = Role.create(name: 'owner')
    WorkspaceUser.create(workspace:, user: current_user, role:)
    ChannelUser.create(channel:, user: current_user)
  end

  describe '#commit' do
    let(:params) { { public: 'false' } }

    it 'updates channel' do
      expect { updater.commit }.to change { channel.reload.public }
        .from(true)
        .to(false)
    end

    it 'returns channel' do
      expect(updater.commit).to be_a(Channel)
    end

    describe 'when channel is not valid' do
      let(:params) { { name: '' } }

      it 'does not update channel' do
        expect { updater.commit }.not_to change { channel.reload.name }
      end

      it 'returns false' do
        expect(updater.commit).to be(false)
      end
    end
  end
end
