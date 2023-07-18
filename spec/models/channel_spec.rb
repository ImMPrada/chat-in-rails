require 'rails_helper'

RSpec.describe Channel, type: :model do
  subject(:channel) { build(:channel) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    describe 'name format' do
      it { is_expected.to allow_value('RUBY rules').for(:name) }
      it { is_expected.to allow_value('RUBY_rules').for(:name) }
      it { is_expected.not_to allow_value('ruby.RULESe').for(:name) }
      it { is_expected.not_to allow_value('RUBY/rules').for(:name) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:channel_users).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:channel_users) }
    it { is_expected.to belong_to(:workspace) }
    it { is_expected.to have_many(:messages).dependent(:destroy) }
  end

  describe '#message_box_turbo_tag' do
    it 'returns the correct turbo tag' do
      expect(channel.message_box_turbo_tag).to eq("channel_#{channel.id}_message_box")
    end
  end

  describe '#messages_turbo_tag' do
    it 'returns the correct turbo tag' do
      expect(channel.messages_turbo_tag).to eq("channel_#{channel.id}_messages")
    end
  end
end
