json.extract! qanswer, :id, :answer, :attach, :question_id, :supplier_id, :created_at, :updated_at
json.url qanswer_url(qanswer, format: :json)
