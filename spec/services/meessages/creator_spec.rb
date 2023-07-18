require 'rails_helper'

RSpec.describe Messages::Creator do
  subject(:creator) { described_class.new(params, channel, current_user) }

  let(:current_user) { create(:user) }
  let(:channel) { create(:channel) }

  describe '#commit' do
    let(:params) { { content: 'test channel' } }

    it 'creates channel' do
      expect { creator.commit }.to change(Message, :count).by(1)
    end

    it 'returns channel' do
      expect(creator.commit).to be_a(Message)
    end

    describe 'when channel is not valid' do
      let(:params) { { content: '' } }

      it 'does not create channel' do
        expect { creator.commit }.not_to change(Message, :count)
      end

      it 'returns false' do
        expect(creator.commit).to be(false)
      end

      it 'returns errors messages' do
        expect{ creator.commit }.to change { creator.errors_messages }
          .from([])
          .to(["Content can't be blank"])
      end
    end
  end
end
