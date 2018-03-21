class Contact < ApplicationRecord
	validates :name, :phone, :email, :subject, :message, presence: true
	validates :email, uniqueness: true
end
