class Supplier < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :requests
  has_and_belongs_to_many :categories
  has_many :messages, dependent: :destroy
  has_many :bids, dependent: :destroy
  
end
