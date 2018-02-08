class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :unit
      t.float :quantity
      t.text :description
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
