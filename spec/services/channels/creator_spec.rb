require 'rails_helper'

RSpec.describe Channels::Creator do
  subject(:creator) { described_class.new(params, current_user, workspace) }

  let(:current_user) { create(:user) }
  let(:workspace) { create(:workspace) }

  before do
    role = Role.create(name: 'owner')
    WorkspaceUser.create(workspace:, user: current_user, role:)
  end

  describe '#commit' do
    let(:params) { { name: 'test channel' } }

    it 'creates channel' do
      expect { creator.commit }.to change(Channel, :count).by(1)
    end

    it 'creates channel members' do
      expect { creator.commit }.to change(ChannelUser, :count).by(1)
    end

    it 'returns channel' do
      expect(creator.commit).to be_a(Channel)
    end

    describe 'when channel is not valid' do
      let(:params) { { name: '' } }

      it 'does not create channel' do
        expect { creator.commit }.not_to change(Channel, :count)
      end

      it 'does not create channel members' do
        expect { creator.commit }.not_to change(ChannelUser, :count)
      end

      it 'returns false' do
        expect(creator.commit).to be(false)
      end

      it 'returns errors messages' do
        expect{ creator.commit }.to change { creator.errors_messages }
          .from([])
          .to(["Name can't be blank"])
      end
    end
  end
end
