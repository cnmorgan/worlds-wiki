class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.text :summary
      t.text :content
      t.references :sub_wiki

      t.timestamps
    end
  end
end
