class Request < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :folder
  has_and_belongs_to_many :suppliers
  has_many :items
  has_many :questions
  has_many :messages
  
end
