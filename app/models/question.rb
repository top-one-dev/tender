class Question < ApplicationRecord
  belongs_to :request
  has_many :qanswers, dependent: :destroy
end
