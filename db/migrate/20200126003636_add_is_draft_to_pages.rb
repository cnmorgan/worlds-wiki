class AddIsDraftToPages < ActiveRecord::Migration[6.0]
  def change
    add_column :pages, :is_draft, :boolean, :default => false
  end
end
