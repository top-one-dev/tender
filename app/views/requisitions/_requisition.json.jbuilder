json.extract! requisition, :id, :name, :description, :delivery_date, :quantity, :budget, :budget_currency, :project, :cost_center, :delivery_address, :contact_name, :contact_email, :contact_phone, :contact_department, :contact_manager, :additional_document, :company_id, :user_id, :status, :created_at, :updated_at
json.url requisition_url(requisition, format: :json)
