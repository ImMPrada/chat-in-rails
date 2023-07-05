module Workspaces
  class Creator
    def initialize(params, user)
      @workspace = Workspace.new(params)
      @user = user
    end

    def workspace_valid?
      workspace.valid?
    end

    def errors
      return unless workspace.errors.any?

      workspace.errors
    end

    def name
      workspace.name
    end

    def commit
      raise return_error unless workspace.valid?

      workspace.save!
      owner_role = Role.find_by(name: 'owner')
      workspace_user = WorkspaceUser.new(user:, workspace:, role: owner_role)

      return workspace if workspace_user.save

      raise return_error
    end

    private

    attr_reader :user, :workspace

    def return_error
      StandardError.new 'Something went wrong, please try again'
    end
  end
end
