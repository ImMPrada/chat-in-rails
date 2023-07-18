require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    describe 'email format' do
      it { is_expected.to allow_value('email@addresse.foo').for(:email) }
      it { is_expected.not_to allow_value('foo').for(:email) }
    end

    describe 'username format' do
      it { is_expected.to allow_value('username').for(:username) }
      it { is_expected.to allow_value('username123').for(:username) }
      it { is_expected.to allow_value('us3rname').for(:username) }
      it { is_expected.to allow_value('user_name').for(:username) }
      it { is_expected.to allow_value('user-name').for(:username) }
      it { is_expected.to allow_value('user.name').for(:username) }
      it { is_expected.not_to allow_value('user name').for(:username) }
      it { is_expected.not_to allow_value('user@name').for(:username) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:workspace_users).dependent(:destroy) }
    it { is_expected.to have_many(:workspace_channel_users).dependent(:destroy) }
    it { is_expected.to have_many(:workspaces).through(:workspace_users) }
    it { is_expected.to have_many(:roles).through(:workspace_users) }
  end

  describe '#owner?' do
    let(:workspace) { create(:workspace) }
    let(:other_workspace) { create(:workspace) }
    let(:other_user) { create(:user) }

    before do
      role = create(:role, name: 'owner')
      create(:workspace_user, user:, workspace:, role:)
      create(:workspace_user, user: other_user, workspace: other_workspace, role:)
    end

    describe 'when user is not owner' do
      it 'returns false' do
        expect(user.owner?(other_workspace)).to be(false)
      end
    end

    describe 'when user is owner' do
      it 'returns true' do
        expect(user.owner?(workspace)).to be(true)
      end
    end
  end

  describe '#admin?' do
    let(:workspace) { create(:workspace) }
    let(:other_workspace) { create(:workspace) }
    let(:other_user) { create(:user) }

    before do
      role = create(:role, name: 'admin')
      create(:workspace_user, user:, workspace:, role:)
      create(:workspace_user, user: other_user, workspace: other_workspace, role:)
    end

    describe 'when user is not admin' do
      it 'returns false' do
        expect(user.admin?(other_workspace)).to be(false)
      end
    end

    describe 'when user is admin' do
      it 'returns true' do
        expect(user.admin?(workspace)).to be(true)
      end
    end
  end

  describe '#member?' do
    let(:workspace) { create(:workspace) }
    let(:other_workspace) { create(:workspace) }
    let(:other_user) { create(:user) }

    before do
      role = create(:role, name: 'member')
      create(:workspace_user, user:, workspace:, role:)
      create(:workspace_user, user: other_user, workspace: other_workspace, role:)
    end

    describe 'when user is not member' do
      it 'returns false' do
        expect(user.member?(other_workspace)).to be(false)
      end
    end

    describe 'when user is member' do
      it 'returns true' do
        expect(user.member?(workspace)).to be(true)
      end
    end
  end

  describe '#message_box_turbo_tag' do
    it 'returns the message box turbo tag' do
      expect(user.message_box_turbo_tag).to eq("user_#{user.id}_message_box")
    end
  end

  describe '#messages_turbo_tag' do
    it 'returns the messages turbo tag' do
      expect(user.messages_turbo_tag).to eq("user_#{user.id}_messages")
    end
  end
end
