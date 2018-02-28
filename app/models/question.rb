class Question < ApplicationRecord
  belongs_to :request, dependent: :destroy
end
