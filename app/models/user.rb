class User < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :searches
  has_many :orders

  # Custom validations
  validates :name, presence: true
end
