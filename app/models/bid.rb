class Bid < ApplicationRecord
  belongs_to :request
  belongs_to :supplier
  has_many :ianswers, dependent: :destroy
  has_many :qanswers, dependent: :destroy
end
