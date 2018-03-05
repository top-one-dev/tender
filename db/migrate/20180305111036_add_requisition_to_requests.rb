class AddRequisitionToRequests < ActiveRecord::Migration[5.0]
  def change
    add_reference :requests, :requisition, foreign_key: true
  end
end
