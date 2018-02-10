class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :logo
      t.string :country
      t.string :city
      t.string :address
      t.string :zip
      t.string :email
      t.integer :phone
      t.string :homepage
      t.string :business_type
      t.string :employees
      t.string :turnover
      t.string :established
      t.text :introduction
      t.string :language
      t.integer :user

      t.timestamps
    end
  end
end
