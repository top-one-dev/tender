json.extract! supplier, :id, :name, :address, :email, :categories, :user_id, :created_at, :updated_at
json.url supplier_url(supplier, format: :json)
