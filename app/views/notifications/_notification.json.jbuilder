json.extract! notification, :id, :messages, :join_company, :reject_compay, :participate_request, :new_bid, :not_participate_request, :invit_request, :changed_request, :reminder_end, :request_decision, :label_tender_scoring, :submitted_requisition, :messages_requisition, :user_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)
