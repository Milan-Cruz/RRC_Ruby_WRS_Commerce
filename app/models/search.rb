class Search < ApplicationRecord
  belongs_to :user

  # Validations
  validates :user_id, presence: true
  validates :query, presence: true, length: { maximum: 255 }

  # Define searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id user_id query created_at updated_at]
  end

  # Define searchable associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end
end
