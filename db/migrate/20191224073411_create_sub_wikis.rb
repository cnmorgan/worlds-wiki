class CreateSubWikis < ActiveRecord::Migration[6.0]
  def change
    create_table :sub_wikis do |t|
      t.references :world, null: false, foreign_key: true

      t.timestamps
    end
  end
end
