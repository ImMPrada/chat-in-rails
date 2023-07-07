require 'rails_helper'

RSpec.describe Role, type: :model do
  subject(:role) { build(:role) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    describe 'name format' do
      it { is_expected.to allow_value('role').for(:name) }
      it { is_expected.not_to allow_value('user_role').for(:name) }
      it { is_expected.not_to allow_value('user-role').for(:name) }
      it { is_expected.not_to allow_value('user.role').for(:name) }
      it { is_expected.not_to allow_value('role123').for(:name) }
      it { is_expected.not_to allow_value('user role').for(:name) }
      it { is_expected.not_to allow_value('user@role').for(:name) }
    end
  end

  describe '#admin?' do
    describe 'when role is admin' do
      let(:role) { build(:role, name: 'admin') }

      it { expect(role.admin?).to be(true) }
    end

    describe 'when role is not admin' do
      let(:role) { build(:role, name: 'owner') }

      it { expect(role.admin?).to be(false) }
    end
  end

  describe '#owner?' do
    describe 'when role is owner' do
      let(:role) { build(:role, name: 'owner') }

      it { expect(role.owner?).to be(true) }
    end

    describe 'when role is not owner' do
      let(:role) { build(:role, name: 'admin') }

      it { expect(role.owner?).to be(false) }
    end
  end

  describe '#member?' do
    describe 'when role is member' do
      let(:role) { build(:role, name: 'member') }

      it { expect(role.member?).to be(true) }
    end

    describe 'when role is not member' do
      let(:role) { build(:role, name: 'admin') }

      it { expect(role.member?).to be(false) }
    end
  end
end
