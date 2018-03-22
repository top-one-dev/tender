class AddFieldsToRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :procuring_entity, :string
    add_column :requests, :submission_type, :string
    add_column :requests, :bidder_fee, :float
    add_column :requests, :bid_bond, :float
    add_column :requests, :special_remarks, :string
  end
end
