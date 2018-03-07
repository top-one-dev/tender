class Requisition < ApplicationRecord
  belongs_to :company
  belongs_to :user # assigned user
  has_one :request
  has_many :stockholders, dependent: :destroy
  has_many :messages, dependent: :destroy
end
