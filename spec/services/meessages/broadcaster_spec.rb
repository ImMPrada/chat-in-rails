require 'rails_helper'

RSpec.describe Messages::Broadcaster do
  subject(:broadcaster) { described_class.new(message, controller) }

  let(:controller) { double('controller', render_to_string: 'rendered') }
  let(:user) { create(:user) }

  describe '#broadcast_to_user_dm' do
    let(:message) { create(:message, author: user, classifiable: user) }
    let(:user_ids) { [user.id, other_user.id] }
    let(:other_user) { create(:user) }

    it 'broadcasts to the correct containers' do
      expect(broadcaster).to receive(:broadcast_to).with(
        [
          "user_#{user_ids.first}_user_#{user_ids.second}",
          "user_#{user_ids.second}_user_#{user_ids.first}"
        ]
      )

      broadcaster.broadcast_to_user_dm(user_ids)
    end
  end

  describe '#broadcast_to_channel' do
    let(:message) { create(:message, author: user, classifiable: channel) }
    let(:channel_id) { channel.id }
    let(:channel) { create(:channel) }

    it 'broadcasts to the correct containers' do
      expect(broadcaster).to receive(:broadcast_to).with(["channel_#{channel_id}"])

      broadcaster.broadcast_to_channel(channel_id)
    end
  end
end
