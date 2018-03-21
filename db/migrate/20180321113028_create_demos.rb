class CreateDemos < ActiveRecord::Migration[5.0]
  def change
    create_table :demos do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :company
      t.string :role
      t.string :status

      t.timestamps
    end
  end
end
