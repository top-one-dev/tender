class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :name
      t.datetime :end_time
      t.text :description
      t.string :attach
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
