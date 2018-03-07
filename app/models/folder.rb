class Folder < ApplicationRecord
	has_many :requests, dependent: :destroy
end
