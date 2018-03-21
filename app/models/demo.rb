class Demo < ApplicationRecord
	validates :first_name, :last_name, :phone, :email, :company, :role, presence: true
	# validates :email, uniqueness: true
end
