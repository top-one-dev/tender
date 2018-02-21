class Qanswer < ApplicationRecord
  belongs_to :question
  belongs_to :supplier
end
