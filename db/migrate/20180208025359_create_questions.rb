class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description
      t.string :type
      t.boolean :enable_attatch
      t.boolean :mandatory
      t.string :options
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
