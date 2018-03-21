class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :subject
      t.text :message
      t.text :status

      t.timestamps
    end
  end
end
