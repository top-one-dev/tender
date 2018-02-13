class CreateJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :requests, :suppliers do |t|
      t.index [:request_id, :supplier_id]
      t.index [:supplier_id, :request_id]
    end
  end
end
