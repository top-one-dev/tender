class Supplier < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :requests
  has_many :messages
  has_many :bids
end
