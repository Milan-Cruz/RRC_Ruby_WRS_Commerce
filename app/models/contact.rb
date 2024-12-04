class Contact < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[id address email phone opening_hours created_at updated_at]
  end
end
