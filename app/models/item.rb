class Item < ApplicationRecord
  belongs_to :request, dependent: :destroy
end
