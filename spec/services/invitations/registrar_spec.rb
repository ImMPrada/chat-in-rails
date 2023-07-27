require 'rails_helper'

RSpec.describe Invitations::Registrar do
  subject(:registrar) { described_class.new(invitation, user) }

  let(:user) { create(:user) }
  let(:invitation) { build(:invitation, workspace:) }
  let(:workspace) { create(:workspace) }

  before { Role.create(name: 'member') }

  describe '#commit' do
    describe 'when there is no problem' do
      before { Channel.create(name: 'general', workspace:) }
  
      it 'adds user to workspace' do
        expect { registrar.commit }.to change(WorkspaceUser, :count).by(1)
      end
  
      it 'adds user to general channel' do
        expect { registrar.commit }.to change(ChannelUser, :count).by(1)
      end
  
      it 'deactivates invitation' do
        registrar.commit
        expect(invitation.active?).to be false
      end
  
      it 'returns true' do
        expect(registrar.commit).to be true
      end
    end

    describe 'when there is no general channel at workspace' do
      before { Channel.create(name: 'nongeneral', workspace:) }

      it 'returns false' do
        expect(registrar.commit).to be false
      end
    end

    describe 'when invitation is nil' do
      let(:invitation) { nil }

      it 'returns false' do
        expect(registrar.commit).to be false
      end
    end

    describe 'when invitation is not active' do
      let(:invitation) { build(:invitation, active: false, workspace:) }

      it 'returns false' do
        expect(registrar.commit).to be false
      end
    end
  end
end
