class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :sub_wiki, null: false, foreign_key: true
      t.references :category

      t.timestamps
    end
  end
end
