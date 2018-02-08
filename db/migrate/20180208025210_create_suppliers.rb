class CreateSuppliers < ActiveRecord::Migration[5.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :categories
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
