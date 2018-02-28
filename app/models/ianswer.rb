class Ianswer < ApplicationRecord
  belongs_to :item, dependent: :destroy
  belongs_to :bid, dependent: :destroy
end
