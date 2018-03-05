class Message < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  belongs_to :request
  belongs_to :requisition
end
