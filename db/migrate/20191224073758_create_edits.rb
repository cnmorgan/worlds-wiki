class CreateEdits < ActiveRecord::Migration[6.0]
  def change
    create_table :edits do |t|
      t.text :summary
      t.references :user, null: false, foreign_key: true
      t.references :page, null: false, foreign_key: true

      t.timestamps
    end
  end
end
