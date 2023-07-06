class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.string :name, null: false
      t.string :avatar_url, null: false

      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
