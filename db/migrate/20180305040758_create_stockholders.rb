class CreateStockholders < ActiveRecord::Migration[5.0]
  def change
    create_table :stockholders do |t|
      t.string :name
      t.string :email
      t.string :job
      t.integer :phone
      t.references :requisition, foreign_key: true

      t.timestamps
    end
  end
end
