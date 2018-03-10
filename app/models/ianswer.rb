class Ianswer < ApplicationRecord
  belongs_to :item
  belongs_to :bid

  def item_total
  	self.unit_price * self.item.quantity
  end
end
