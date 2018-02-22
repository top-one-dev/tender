class CreateIanswers < ActiveRecord::Migration[5.0]
  def change
    create_table :ianswers do |t|
      t.float :unit_price
      t.float :quantity
      t.references :item, foreign_key: true
      t.references :bid, foreign_key: true

      t.timestamps
    end
  end
end
