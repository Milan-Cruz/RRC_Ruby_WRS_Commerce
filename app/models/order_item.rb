class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :car

  validates :price_at_purchase, :quantity, presence: true
end
