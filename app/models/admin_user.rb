class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Validation for the presence and format of email (optional since Devise already validates email)
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Validation for password length (Devise already enforces this, but it's specified here for clarity)
  validates :password, length: { minimum: 6 }, if: -> { password.present? }

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id email created_at updated_at]
  end
end
