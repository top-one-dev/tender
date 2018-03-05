class AddRequisitionToMessages < ActiveRecord::Migration[5.0]
  def change
    add_reference :messages, :requisition, foreign_key: true
  end
end
