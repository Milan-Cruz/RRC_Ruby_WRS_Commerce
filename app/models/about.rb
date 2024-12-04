class About < ApplicationRecord
  # Validation for presence of description
  validates :description, presence: true, length: { minimum: 10, maximum: 2000 }

  # Ransack attributes for filtering
  def self.ransackable_attributes(auth_object = nil)
    %w[id description created_at updated_at]
  end
end
