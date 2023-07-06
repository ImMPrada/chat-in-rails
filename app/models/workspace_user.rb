class WorkspaceUser < ApplicationRecord
  belongs_to :user
  belongs_to :workspace
  belongs_to :role
end
