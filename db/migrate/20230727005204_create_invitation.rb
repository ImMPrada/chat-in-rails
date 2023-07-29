class CreateInvitation < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.boolean :active, default: true
      t.string :token, null: false

      t.references :workspace, null: false, foreign_key: true
      t.references :receiver, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :invitations, :token, unique: true
  end
end
