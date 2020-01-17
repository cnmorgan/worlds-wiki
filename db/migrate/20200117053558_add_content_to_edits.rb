class AddContentToEdits < ActiveRecord::Migration[6.0]
  def change
    add_column :edits, :content, :text
  end
end
