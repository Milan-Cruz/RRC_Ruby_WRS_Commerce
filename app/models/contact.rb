class Contact < ApplicationRecord
  # Validations
  validates :address, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :phone, presence: true, format: { with: /\A\+?[0-9\s\-]+\z/, message: "must be a valid phone number" }
  validates :opening_hours, presence: true

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id address email phone opening_hours created_at updated_at]
  end
end
