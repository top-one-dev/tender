json.extract! message, :id, :content, :attach, :user_id, :supplier_id, :request_id, :created_at, :updated_at
json.url message_url(message, format: :json)
