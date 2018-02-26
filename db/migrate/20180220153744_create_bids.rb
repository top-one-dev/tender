class CreateBids < ActiveRecord::Migration[5.0]
  def change
    create_table :bids do |t|
      t.references :request, foreign_key: true
      t.references :supplier, foreign_key: true
      t.text :content
      t.string :bid_currency
      t.float :bid_budget
      t.string :document
      t.string :status

      t.timestamps
    end
  end
end
