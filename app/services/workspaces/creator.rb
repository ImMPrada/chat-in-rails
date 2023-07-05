module Workspaces
  class Creator
    def initialize(params, user)
      @params = params
      @user = user
    end

    def workspace_valid?
      @workspace = Workspace.new(@params)
      workspace.valid?
    end

    def errors
      return unless workspace.errors.any?

      workspace.errors
    end

    private

    attr_reader :params, :user, :workspace
  end
end
