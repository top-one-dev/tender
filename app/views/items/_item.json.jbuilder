json.extract! item, :id, :name, :unit, :quantity, :description, :request_id, :created_at, :updated_at
json.url item_url(item, format: :json)
