class AddDescriptionToWorkspaceChannels < ActiveRecord::Migration[7.0]
  def change
    add_column :workspace_channels, :description, :string
  end
end
