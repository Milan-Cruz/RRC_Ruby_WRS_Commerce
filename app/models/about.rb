class About < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[id description created_at updated_at]
  end
end
