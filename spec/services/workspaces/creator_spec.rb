require 'rails_helper'

RSpec.describe Workspaces::Creator do
  subject(:creator) { described_class.new(params, user) }

  let(:user) { create(:user) }

  describe '#workspace_valid?' do
    describe 'when workspace is valid' do
      let(:params) { { name: 'test workspace' } }

      it 'returns true' do
        expect(creator.workspace_valid?).to be true
      end
    end

    describe 'when workspace is invalid' do
      let(:params) { { name: '' } }

      it 'returns false' do
        expect(creator.workspace_valid?).to be false
      end
    end
  end

  describe '#errors' do
    describe 'when workspace is valid' do
      let(:params) { { name: 'test workspace' } }

      it 'returns nil' do
        expect(creator.errors).to be_nil
      end
    end

    describe 'when workspace is invalid' do
      let(:params) { { name: '' } }

      before { creator.workspace_valid? }

      it 'returns errors' do
        expect(creator.errors).to be_present
      end
    end
  end

  describe '#name' do
    let(:params) { { name: 'test workspace' } }

    it 'returns workspace name' do
      expect(creator.name).to eq 'test workspace'
    end
  end

  describe '#commit' do
    describe 'when workspace is valid' do
      let(:params) { { name: 'test workspace' } }

      before do
        Role.create(name: 'owner')
        creator.commit
      end

      it 'creates workspace' do
        expect(Workspace.first.name).to eq 'test workspace'
      end

      it 'creates workspace user' do
        expect(WorkspaceUser.first.user).to eq user
      end

      it 'creates a channel named "general"' do
        expect(Channel.first.name).to eq 'general'
      end

      it 'creates channel user by adding the owner user to the channel' do
        expect(ChannelUser.first.user).to eq user
      end

      it 'creates the right number of records' do
        expect(Workspace.count).to eq 1
        expect(WorkspaceUser.count).to eq 1
        expect(Channel.count).to eq 1
        expect(ChannelUser.count).to eq 1
      end
    end

    describe 'when workspace is invalid' do
      let(:params) { { name: '' } }

      it 'raises error' do
        expect { creator.commit }.to raise_error(StandardError)
      end
    end
  end
end
