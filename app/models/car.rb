class Car < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :price_histories
  has_many :order_items
  has_one_attached :image

  # Validations
  validates :make, :model, :trim, :year, :mileage, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :mileage, numericality: { greater_than_or_equal_to: 0 }

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id make model trim year mileage price created_at updated_at]
  end

  # Define searchable associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[categories price_histories order_items]
  end
end
