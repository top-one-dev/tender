class Qanswer < ApplicationRecord
  belongs_to :question, dependent: :destroy
  belongs_to :bid, dependent: :destroy
end
