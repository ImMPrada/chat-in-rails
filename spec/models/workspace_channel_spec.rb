require 'rails_helper'

RSpec.describe WorkspaceChannel, type: :model do
  subject(:workspace_channel) { build(:workspace_channel) }

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
    it { is_expected.to have_many(:workspace_channel_users).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:workspace_channel_users) }
    it { is_expected.to belong_to(:workspace) }
    it { is_expected.to have_many(:messages).dependent(:destroy) }
  end
end
