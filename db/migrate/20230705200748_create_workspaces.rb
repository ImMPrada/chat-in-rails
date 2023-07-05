class CreateWorkspaces < ActiveRecord::Migration[7.0]
  def change
    create_table :workspaces do |t|
      t.string :name, null: false
      t.string :avatar_url, null: false

      t.index :name, unique: true

      t.timestamps
    end
  end
end
