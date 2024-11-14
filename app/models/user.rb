class User < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :searches
  has_many :orders

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id name email created_at updated_at]
  end
end
