class Category < ApplicationRecord
  has_and_belongs_to_many :cars

  validates :name, presence: true, uniqueness: true

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id name updated_at]
  end

  # Optionally, define associations that can be searched
  def self.ransackable_associations(auth_object = nil)
    %w[cars]
  end
end
