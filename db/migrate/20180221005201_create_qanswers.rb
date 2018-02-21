class CreateQanswers < ActiveRecord::Migration[5.0]
  def change
    create_table :qanswers do |t|
      t.text :answer
      t.string :attach
      t.references :question, foreign_key: true
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
