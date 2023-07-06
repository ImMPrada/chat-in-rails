require 'rails_helper'

RSpec.describe Workspace, type: :model do
  subject(:workspace) { build(:workspace) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

    describe 'username format' do
      it { is_expected.to allow_value('RUBY rules').for(:name) }
      it { is_expected.to allow_value('RUBY_rules').for(:name) }
      it { is_expected.not_to allow_value('ruby.RULESe').for(:name) }
      it { is_expected.not_to allow_value('RUBY/rules').for(:name) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:workspace_users).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:workspace_users) }
  end
end
