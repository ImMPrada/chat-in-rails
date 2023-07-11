class CreateWorkspaceChannelUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :workspace_channel_users do |t|
      t.references :workspace_channel, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
