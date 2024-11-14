class AdminUser < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id email created_at updated_at]
  end
end
