class AddIsSiteAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_site_admin, :boolean, :default => false
  end
end
