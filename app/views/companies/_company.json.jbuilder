json.extract! company, :id, :name, :logo, :country, :city, :address, :zip, :email, :phone, :homepage, :employees, :turnover, :established, :introduction, :language, :user, :created_at, :updated_at
json.url company_url(company, format: :json)
