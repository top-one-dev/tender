class Message < ApplicationRecord
  belongs_to :user
  belongs_to :supplier
  belongs_to :request
end
