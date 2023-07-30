require 'rails_helper'

RSpec.describe Invitations::Creator do
  subject(:creator) { described_class.new(workspace, user) }

  let(:user) { create(:user) }
  let(:workspace) { build(:workspace) }

  describe '#commit' do
    it 'creates invitation' do
      expect { creator.commit }.to change(Invitation, :count).by(1)
    end

    it 'returns invitation' do
      expect(creator.commit).to be_a(Invitation)
    end

    describe 'when workspace is invalid' do
      let(:workspace) { nil }

      it 'does not create invitation' do
        expect { creator.commit }.not_to change(Invitation, :count)
      end

      it 'returns false' do
        expect(creator.commit).to be(false)
      end
    end
  end
end
