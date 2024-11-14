class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :cars, through: :order_items

  # Validations
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id user_id total_price status created_at updated_at]
  end

  # Define searchable associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[user order_items cars]
  end
end
