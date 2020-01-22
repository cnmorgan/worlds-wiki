class RemoveSummaryFromPages < ActiveRecord::Migration[6.0]
  def change
    remove_column :pages, :summary
  end
end
