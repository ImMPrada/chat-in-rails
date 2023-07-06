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
    it { is_expected.to have_many(:workspaces).through(:workspace_users) }
    it { is_expected.to have_many(:roles).through(:workspace_users) }
  end
end
