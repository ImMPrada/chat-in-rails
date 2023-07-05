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
end
