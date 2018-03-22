class Category < ApplicationRecord
	has_and_belongs_to_many :requests
	has_and_belongs_to_many :suppliers
	
end
