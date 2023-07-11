class WorkspaceChannelUser < ApplicationRecord
  belongs_to :user
  belongs_to :workspace_channel
end
