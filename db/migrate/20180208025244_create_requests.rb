class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.datetime :end_time
      t.text :description
      t.string :attach
      t.string :type
      t.references :user, foreign_key: true
      t.references :company, foreigh_key: true
      t.references :folder, foreign_key: true

      t.timestamps
    end
  end
end
