class Bid < ApplicationRecord
  belongs_to :request
  belongs_to :supplier
  has_many :ianswers
  has_many :qanswers
end
