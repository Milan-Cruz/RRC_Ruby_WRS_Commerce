class PriceHistory < ApplicationRecord
  belongs_to :car

  validates :date_recorded, :price, presence: true
end
