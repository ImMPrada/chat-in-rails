module Invitations
  class Creator
    attr_reader :workspace, :invitation

    def initialize(workspace, user)
      @workspace = workspace
      @user = user
    end

    def commit
      build_invitation
      return invitation if invitation.save

      false
    end

    private

    attr_reader :user

    def build_invitation
      @invitation = Invitation.new(token: SecureRandom.hex(20), workspace:)
    end
  end
end
