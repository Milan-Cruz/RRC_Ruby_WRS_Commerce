class User < ApplicationRecord
  # Devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :searches
  has_many :orders

  # Validations
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, :city, :postal_code, :province, presence: true

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id name email address city postal_code province created_at updated_at]
  end
end
