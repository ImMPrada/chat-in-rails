class AddPublicToChannels < ActiveRecord::Migration[7.0]
  def change
    add_column :channels, :public, :boolean, default: true
  end
end
