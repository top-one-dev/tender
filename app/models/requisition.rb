class Requisition < ApplicationRecord
  belongs_to :company
  belongs_to :user # assigned user
  has_one :request
  has_many :stockholders
  has_many :messages
end
