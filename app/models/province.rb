class Province < ApplicationRecord
  # Associations
  has_many :users

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :gst, :pst, numericality: { greater_than_or_equal_to: 0 }

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id name gst pst created_at updated_at]
  end

  # Define searchable associations for Ransack (if needed)
  def self.ransackable_associations(auth_object = nil)
    %w[users]
  end

  # Dynamic HST Calculation
  def hst
    gst + pst
  end
end
