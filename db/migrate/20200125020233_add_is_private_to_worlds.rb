class AddIsPrivateToWorlds < ActiveRecord::Migration[6.0]
  def change
    add_column :worlds, :is_private, :boolean, :default => false
  end
end
