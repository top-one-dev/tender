class AddCompanyToSupplier < ActiveRecord::Migration[5.0]
  def change
    add_column :suppliers, :company, :string
    add_column :suppliers, :mobile, :string
    add_column :suppliers, :phone, :string
  end
end
