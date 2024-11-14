class PriceHistory < ApplicationRecord
  belongs_to :car

  # Validations
  validates :price, :recorded_at, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id car_id price recorded_at created_at updated_at]
  end

  # Define searchable associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[car]
  end
end
