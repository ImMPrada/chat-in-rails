class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :content, null: false

      t.references :responded_message, foreign_key: { to_table: :messages }
      t.references :classifiable, polymorphic: true, null: false
      t.references :author, foreign_key: { to_table: :users }, null: false
      t.timestamps
    end
  end
end
