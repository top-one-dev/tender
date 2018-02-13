class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.datetime :end_time
      t.text :description
      t.string :attach
      t.string :permission
      t.boolean :total_price_must
      t.boolean :allow_alternative_bids
      t.boolean :sealed_bids
      t.string :preferred_currency
      t.float :expected_budget
      t.string :request_type
      t.references :user, foreign_key: true
      t.references :company, foreigh_key: true
      t.references :folder, foreign_key: true

      t.timestamps
    end
  end
end
