class AddReasonToRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :clarificatoin, :text
    add_column :requests, :extend_reason, :text
    add_column :requests, :cancel_reason, :text
  end
end
