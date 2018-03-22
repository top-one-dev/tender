class CreateJoinTableCategorySupplier < ActiveRecord::Migration[5.0]
  def change
    create_join_table :categories, :suppliers do |t|
      t.index [:category_id, :supplier_id]
      t.index [:supplier_id, :category_id]
    end
  end
end
