class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :car

  # Validations
  validates :price_at_purchase, :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validates :price_at_purchase, numericality: { greater_than_or_equal_to: 0 }

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id order_id car_id price_at_purchase quantity created_at updated_at]
  end

  # Define searchable associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[order car]
  end
end
