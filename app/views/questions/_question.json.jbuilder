json.extract! question, :id, :title, :description, :type, :enable_attatch, :mandatory, :options, :request_id, :created_at, :updated_at
json.url question_url(question, format: :json)
