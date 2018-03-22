class CreateJoinTableCategoryRequest < ActiveRecord::Migration[5.0]
  def change
    create_join_table :categories, :requests do |t|
      t.index [:category_id, :request_id]
      t.index [:request_id, :category_id]
    end
  end
end
