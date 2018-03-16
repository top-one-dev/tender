class Item < ApplicationRecord
  belongs_to :request
  has_many :ianswers, dependent: :destroy
end
