class CreateRequisitions < ActiveRecord::Migration[5.0]
  def change
    create_table :requisitions do |t|
      t.string :name
      t.string :description
      t.datetime :delivery_date
      t.float :quantity
      t.float :budget
      t.string :budget_currency
      t.string :project
      t.string :cost_center
      t.string :delivery_address
      t.string :contact_name
      t.string :contact_email
      t.integer :contact_phone
      t.string :contact_department
      t.string :contact_manager
      t.string :additional_document
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
