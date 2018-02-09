class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.boolean :messages
      t.boolean :join_company
      t.boolean :reject_compay
      t.boolean :participate_request
      t.boolean :new_bid
      t.boolean :not_participate_request
      t.boolean :invit_request
      t.boolean :changed_request
      t.boolean :reminder_end
      t.boolean :request_decision
      t.boolean :label_tender_scoring
      t.boolean :submitted_requisition
      t.boolean :messages_requisition
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
