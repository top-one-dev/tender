class Company < ApplicationRecord
	validates :name, :country, :email, presence: true
	validates :name, :email, uniqueness: true
	has_many :requests
	has_and_belongs_to_many :users
	
end
