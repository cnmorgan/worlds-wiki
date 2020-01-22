class AddUserIdToPages < ActiveRecord::Migration[6.0]
  def change
    add_reference :pages, :user, index: true
    add_foreign_key :pages, :users
  end
end
