class Car < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :price_histories
  has_many :order_items

  validates :make, :model, :trim, :year, :mileage, :price, presence: true
end
