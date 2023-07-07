require 'rails_helper'

RSpec.describe Channels::Creator do
  subject(:creator) { described_class.new(params, current_user, workspace, users_ids) }

  let(:current_user) { create(:user) }
  let(:workspace) { create(:workspace) }

  describe '#commit' do
    let(:params) { { name: 'test channel' } }
    let(:users_ids) { [current_user.id] }

    before do
      user_to_add1 = create(:user)
      users_ids << user_to_add1.id
      user_to_add2 = create(:user)
      users_ids << user_to_add2.id
      user_to_add3 = create(:user)
      users_ids << user_to_add3.id
      user_to_add4 = create(:user)
      users_ids << user_to_add4.id
    end

    it 'creates channel' do
      expect { creator.commit }.to change(Channel, :count).by(1)
    end

    it 'creates channel members' do
      expect { creator.commit }.to change(ChannelUser, :count).by(5)
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

    describe "when any of the users doesn't exist" do
      before do
        users_ids << current_user.id + 6
      end

      it 'creates the channel' do
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
          .to(["User must exist"])
      end
    end
  end
end
