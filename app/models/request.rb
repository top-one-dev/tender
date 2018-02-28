class Request < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :company, dependent: :destroy
  belongs_to :folder
  has_and_belongs_to_many :suppliers
  has_many :items
  has_many :questions
  has_many :messages
  has_many :bids
  
end
