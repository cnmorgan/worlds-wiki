class CreateAdminPrivileges < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_privileges do |t|
      t.references :user
      t.references :world, null: false, foreign_key: true

      t.timestamps
    end
  end
end
