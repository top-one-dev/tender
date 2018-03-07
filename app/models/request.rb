class Request < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :requisition
  belongs_to :folder
  has_and_belongs_to_many :suppliers
  has_many :items, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :bids, dependent: :destroy
  
end
