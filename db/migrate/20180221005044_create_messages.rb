class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :attach
      t.string :from
      t.boolean :read
      t.references :user, foreign_key: true
      t.references :supplier, foreign_key: true
      t.references :request, foreign_key: true      

      t.timestamps
    end
  end
end
